# shellcheck shell=zsh

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

  local f=0
  local t=0
  local p=0
  local s=0
  local S=0
  local T=0
  local B=0
  local F=0

  local file
  if [ -d "$dir" ]; then
    for file in $(
      cd "$dir"
      ls -1
    ); do
      local results
      results=$(p6_test_harness_test_run "$dir/$file")

      local ti
      ti=$(printf '%s' "$results" | sed -e 's,.*Tt=,,' -e 's, .*,,')
      local pi
      pi=$(printf '%s' "$results" | sed -e 's,.*Tp=,,' -e 's, .*,,')
      local Pi
      Pi=$(printf '%s' "$results" | sed -e 's,.*TP=,,' -e 's, .*,,')
      local Si
      Si=$(printf '%s' "$results" | sed -e 's,.*TS=,,' -e 's, .*,,')
      local Ti
      Ti=$(printf '%s' "$results" | sed -e 's,.*TT=,,' -e 's, .*,,')
      local Bi
      Bi=$(printf '%s' "$results" | sed -e 's,.*TB=,,' -e 's, .*,,')
      local di
      di=$(printf '%s' "$results" | sed -e 's,.*Td=,,' -e 's, .*,,' )

      t=$((t + ti))
      s=$((s + Pi))
      B=$((B + Bi))
      S=$((S + Si))
      T=$((T + Ti))
      p=$(awk -v p="$p" -v pi="$pi" 'BEGIN { printf "%.3f\n", p + pi }')
      f=$((f + 1))

      p6_test_harness___results "$dir/$file" "$di" "$pi" "$Pi" "$ti" "$Bi" "$Ti" "$Si" >&2
    done
  fi

  if [ "$s" -ne "$t" ]; then
    F=$((t - s))
  fi

  local result
  local rc
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

  local Tt=0
  local Ts=0
  local TS=0
  local TT=0
  local TB=0
  local TF=0

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
    1..*)
      Tt=$(printf '%s' "$line" | sed -e 's,^1..,,' -e 's, *,,')
      ;;
    ok\ *SKIP*\ *)
      TS=$((TS + 1))
      ;;
    not\ *TODO\ *)
      TT=$((TT + 1))
      ;;
    ok\ *TODO\ *)
      TB=$((TB + 1))
      Ts=$((Ts + 1))
      ;;
    not\ ok*)
      TF=$((TF + 1))
      ;;
    ok\ *)
      Ts=$((Ts + 1))
      ;;
    esac
  done

  local Tr=$((TS + TT + TF + Ts))
  local TP=$((TS + Ts + TT))

  local Tp
  if [ "$Tt" -eq 0 ]; then
    Tp=0.00
  else
    Tp=$(awk -v TP="$TP" -v Tt="$Tt" 'BEGIN { printf "%.3f\n", (TP / Tt) * 100 }')
  fi

  local Td
  Td=$(awk '/^real/ { print $2 }' "$log_time" 2>/dev/null | sed -e 's/s//')
  Td=${Td:-0}

  p6_test_state_cleanup "$tmp_dir"

  echo "Tt=$Tt Ts=$Ts TS=$TS TT=$TT TB=$TB TF=$TF Tr=$Tr Tp=$Tp TP=$TP Td=$Td Rc=$rc"
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

  printf '%-30s %6ss %7s%% %4s/%-4s +%s ~%s -%s\n' \
    "$name" "$duration" "$prcnt_passed" "$passed" "$total" "$bonus" "$todo" "$skipped"
}
