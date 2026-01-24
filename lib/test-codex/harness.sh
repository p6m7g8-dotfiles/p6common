# shellcheck shell=zsh

####################################################################
# f: files processed (f += 1)
# t: total tests (t += ti)
# p: percent sum (p += pi)
# s: passed (s += Pi)
# S: skipped (S += Si)
# T: todo (T += Ti)
# B: todo bonus (B += Bi)
# F: failed (F = t - s when s != t)
# ti: per-file total tests
# pi: per-file percent pass
# Pi: per-file passed
# Si: per-file skipped
# Ti: per-file todo
# Bi: per-file todo bonus
# di: per-file duration seconds
# Tt: planned total from TAP plan line
# Ts: passed count per run
# TS: skipped count per run
# TT: todo count per run
# TB: todo bonus count per run
# TF: failed count per run
# Tr: total reported (TS + TT + TF + Ts)
# TP: passable total (TS + Ts + TT)
# Te: effective total (max of Tt, Tr)
# Tp: percent pass (TP / Te * 100)
# Td: duration seconds
# result: PASS|PROVISIONAL|FAIL (based on s==t and B)
# rc: exit code (0 ok, 1 provisional, 2 fail)
# summary: name dur pct pass/total +bonus ~todo -skip
######################################################################

######################################################################
#<
#
# Function: p6_test_harness_tests_run(dir)
#
#  Args:
#	dir -
#
#>
######################################################################
p6_test_harness_tests_run() {
  local dir="$1"

  case $dir in
  *bats) p6_test_harness_tests_run_bats "$dir" ;;
  *t) p6_test_harness_tests_run_local "$dir" ;;
  esac
}

######################################################################
#<
#
# Function: p6_test_harness_tests_run_bats(dir)
#
#  Args:
#	dir -
#
#>
######################################################################
p6_test_harness_tests_run_bats() {
  local dir="$1"

  bats "$dir"
}

######################################################################
#<
#
# Function: p6_test_harness_tests_run_local(dir)
#
#  Args:
#	dir -
#
#>
######################################################################
p6_test_harness_tests_run_local() {
  local dir="$1"

  local f=0 # files processed
  local t=0 # total tests
  local p=0 # percent sum
  local s=0 # passed
  local S=0 # skipped
  local T=0 # xtodo
  local B=0 # xtodo bonus
  local F=0 # failed

  local file
  if [ -d "$dir" ]; then
    for file in $(
      cd "$dir"
      ls -1
    ); do
      local results
      results=$(p6_test_harness_test_run "$dir/$file")

      local ti # total tests
      ti=$(printf '%s' "$results" | sed -e 's,.*Tt=,,' -e 's, .*,,')

      local pi # percent pass
      pi=$(printf '%s' "$results" | sed -e 's,.*Tp=,,' -e 's, .*,,')

      local Pi # passed
      Pi=$(printf '%s' "$results" | sed -e 's,.*TP=,,' -e 's, .*,,')

      local Si # skipped
      Si=$(printf '%s' "$results" | sed -e 's,.*TS=,,' -e 's, .*,,')

      local Ti # xtodo
      Ti=$(printf '%s' "$results" | sed -e 's,.*TT=,,' -e 's, .*,,')

      local Bi # xtodo bonus
      Bi=$(printf '%s' "$results" | sed -e 's,.*TB=,,' -e 's, .*,,')

      local di # duration seconds
      di=$(printf '%s' "$results" | sed -e 's,.*Td=,,' -e 's, .*,,' )

      t=$((t + ti)) # add per-file total tests
      s=$((s + Pi)) # add per-file passed
      B=$((B + Bi)) # add per-file todo bonus
      S=$((S + Si)) # add per-file skipped
      T=$((T + Ti)) # add per-file todo
      p=$(awk -v p="$p" -v pi="$pi" 'BEGIN { printf "%.3f\n", p + pi }') # sum percent pass
      f=$((f + 1)) # increment file count

      # summary args: name=$dir/$file, dur=$di, pct=$pi, pass=$Pi, total=$ti, bonus=$Bi, todo=$Ti, skip=$Si
      p6_test_harness___results "$dir/$file" "$di" "$pi" "$Pi" "$ti" "$Bi" "$Ti" "$Si" >&2
    done
  fi

  if [ "$s" -ne "$t" ]; then
    F=$((t - s)) # failed count when pass != total
  fi

  local result # PASS|PROVISIONAL|FAIL
  local rc # exit code (0 ok, 1 provisional, 2 fail)
  if [ "$s" -ne "$t" ]; then
    result=FAIL
    rc=2
  else
    if [ "$B" -gt 0 ]; then
      result=PROVISIONAL
      rc=1
    else
      result=PASS
      rc=0
    fi
  fi

  echo "Files=$f, Tests=$s/$t, Todo=$T, Fixed=$B, Skipped=$S"
  echo "Result: $result"
  return $rc
}

######################################################################
#<
#
# Function: p6_test_harness_test_run(file)
#
#  Args:
#	file -
#
#>
######################################################################
p6_test_harness_test_run() {
  local file="$1"

  local Tt=0 # total planned
  local Ts=0 # passed
  local TS=0 # skipped
  local TT=0 # xtodo
  local TB=0 # xtodo bonus
  local TF=0 # failed

  local base
  base=$(basename "$file")

  local tmp_dir
  tmp_dir=$(p6_test_state_init) || return 1

  local log_file="$tmp_dir/$base.txt"
  local log_time="$tmp_dir/$base.time"

  command time -p zsh "$file" >"$log_file" 2>"$log_time"
  local rc=$?

  local line
  local IFS=$'\n'
  for line in $(cat "$log_file"); do
    case $line in
    1..*) # plan line: "1..N"
      Tt=$(printf '%s' "$line" | sed -e 's,^1..,,' -e 's, *,,') # planned total
      ;;
    ok\ *SKIP*\ *) # skipped test
      TS=$((TS + 1)) # skipped count
      ;;
    not\ *TODO\ *) # xtodo planned (not ok)
      TT=$((TT + 1)) # xtodo count
      ;;
    ok\ *TODO\ *) # xtodo bonus (ok)
      TB=$((TB + 1)) # xtodo bonus count
      Ts=$((Ts + 1)) # passed count
      ;;
    not\ ok*) # failed test
      TF=$((TF + 1)) # failed count
      ;;
    ok\ *) # passed test
      Ts=$((Ts + 1)) # passed count
      ;;
    esac
  done

  local Tr=$((TS + TT + TF + Ts)) # total reported
  local TP=$((TS + Ts + TT)) # pass/skip/todo total

  local Te=$Tt # effective total
  if [ "$Te" -lt "$Tr" ]; then
    Te=$Tr
  fi

  local Tp # percent pass
  if [ "$Te" -eq 0 ]; then # avoid divide by zero
    Tp=0.00 # percent pass when no tests
  else
    Tp=$(awk -v TP="$TP" -v Te="$Te" 'BEGIN { printf "%.3f\n", (TP / Te) * 100 }') # percent pass
  fi

  local Td # duration seconds
  Td=$(awk '/^real/ { print $2 }' "$log_time" 2>/dev/null | sed -e 's/s//') # duration secs
  Td=${Td:-0} # default when missing

  p6_test_state_cleanup "$tmp_dir"

  # summary: total=$Te pass=$Ts skip=$TS todo=$TT bonus=$TB fail=$TF seen=$Tr pct=$Tp passable=$TP dur=$Td rc=$rc
  echo "Tt=$Te Ts=$Ts TS=$TS TT=$TT TB=$TB TF=$TF Tr=$Tr Tp=$Tp TP=$TP Td=$Td Rc=$rc"
}

######################################################################
#<
#
# Function: p6_test_harness___results(name, duration, prcnt_passed, passed, total, bonus, todo, skipped)
#
#  Args:
#	name -
#	duration -
#	prcnt_passed -
#	passed -
#	total -
#	bonus -
#	todo -
#	skipped -
#
#>
######################################################################
p6_test_harness___results() {
  local name="$1"
  local duration="$2"
  local prcnt_passed="$3"
  local passed="$4"
  local total="$5"
  local bonus="$6"
  local todo="$7"
  local skipped="$8"

  # format: name dur pct pass/total +bonus ~todo -skip
  printf '%-30s %6ss %7s%% %4s/%-4s +%s ~%s -%s\n' \
    "$name" "$duration" "$prcnt_passed" "$passed" "$total" "$bonus" "$todo" "$skipped"
}
