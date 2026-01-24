# shellcheck shell=zsh

######################################################################
#<
#
# Function: p6_test_assert_run_ok(description, [rv=0], [stdout=], [stderr=])
#
#  Args:
#	description -
#	OPTIONAL rv - [0]
#	OPTIONAL stdout - []
#	OPTIONAL stderr - []
#
#>
######################################################################
p6_test_assert_run_ok() {
  local description="$1"
  local rv="${2:-0}"
  local stdout="${3:-}"
  local stderr="${4:-}"

  p6_test_assert_run_rc "$description: return code success" "$rv"

  if [ -n "$stdout" ]; then
    p6_test_assert_eq "$(p6_test_run_stdout)" "$stdout" "$description: custom stdout matches"
  else
    p6_test_assert_run_no_stdout "$description"
  fi

  if [ -n "$stderr" ]; then
    p6_test_assert_eq "$(p6_test_run_stderr)" "$stderr" "$description: custom stderr matches"
  else
    p6_test_assert_run_no_stderr "$description"
  fi
}

######################################################################
#<
#
# Function: p6_test_assert_run_rc(description, rv)
#
#  Args:
#	description -
#	rv -
#
#>
######################################################################
p6_test_assert_run_rc() {
  local description="$1"
  local rv="$2"

  local rc
  rc=$(p6_test_run_rc)

  if p6_test_assert_eq "$rc" "$rv" "$description"; then
    p6_test_tap_diagnostic "stdout: $(p6_test_run_stdout)"
    p6_test_tap_diagnostic "stderr: $(p6_test_run_stderr)"
  fi
}

######################################################################
#<
#
# Function: p6_test_assert_run_no_output(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_run_no_output() {
  local description="$1"
  local reason="$2"

  p6_test_assert_run_no_stdout "$description" "$reason"
  p6_test_assert_run_no_stderr "$description" "$reason"
}

######################################################################
#<
#
# Function: p6_test_assert_run_no_stdout(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_run_no_stdout() {
  local description="$1"
  local reason="$2"

  p6_test_assert_blank "$(p6_test_run_stdout)" "$description: no stdout" "$reason"
}

######################################################################
#<
#
# Function: p6_test_assert_run_no_stderr(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_run_no_stderr() {
  local description="$1"
  local reason="$2"

  p6_test_assert_blank "$(p6_test_run_stderr)" "$description: no stderr" "$reason"
}

######################################################################
#<
#
# Function: p6_test_assert_run_not_ok(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_run_not_ok() {
  local description="$1"
  local reason="$2"

  local rc
  rc=$(p6_test_run_rc)

  p6_test_assert_not_eq "$rc" "0" "$description" "$reason"
}

######################################################################
#<
#
# Function: p6_test_assert_eq(val, const, description, reason)
#
#  Args:
#	val -
#	const -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_eq() {
  local val="$1"
  local const="$2"
  local description="$3"
  local reason="$4"

  local rv=-1
  if [[ "$val" == "$const" ]]; then
    rv=1
    p6_test_tap_ok "$description" "$reason"
  else
    rv=0
    p6_test_tap_not_ok "$description" "$reason"
    p6_test_tap_diagnostic "expected [$const], got [$val]"
  fi

  return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_not_eq(val, const, description, reason)
#
#  Args:
#	val -
#	const -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_not_eq() {
  local val="$1"
  local const="$2"
  local description="$3"
  local reason="$4"

  local rv=-1
  if [[ "$val" == "$const" ]]; then
    rv=0
    p6_test_tap_not_ok "$description" "$reason"
    p6_test_tap_diagnostic "expected [$const], got [$val]"
  else
    rv=1
    p6_test_tap_ok "$description" "$reason"
  fi

  return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_len(val, const, description, reason)
#
#  Args:
#	val -
#	const -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_len() {
  local val="$1"
  local const="$2"
  local description="$3"
  local reason="$4"

  local len=${#val}

  p6_test_assert_eq "$len" "$const" "$description" "$reason"
}

######################################################################
#<
#
# Function: p6_test_assert_contains(val, const, description, reason)
#
#  Args:
#	val -
#	const -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_contains() {
  local val="$1"
  local const="$2"
  local description="$3"
  local reason="$4"

  local rv=-1
  if [[ "$val" =~ $const ]]; then
    rv=1
    p6_test_tap_ok "$description" "$reason"
  else
    rv=0
    p6_test_tap_not_ok "$description" "$reason"
    p6_test_tap_diagnostic "val [$val] does not match [$const]"
  fi

  return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_not_contains(val, const, description, reason)
#
#  Args:
#	val -
#	const -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_not_contains() {
  local val="$1"
  local const="$2"
  local description="$3"
  local reason="$4"

  local rv=-1
  if [[ "$val" =~ $const ]]; then
    rv=0
    p6_test_tap_not_ok "$description" "$reason"
    p6_test_tap_diagnostic "val [$val] matches [$const]"
  else
    rv=1
    p6_test_tap_ok "$description" "$reason"
  fi

  return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_blank(val, description, reason)
#
#  Args:
#	val -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_blank() {
  local val="$1"
  local description="$2"
  local reason="$3"

  local rv=-1
  if [ -z "$val" ]; then
    rv=1
    p6_test_tap_ok "$description" "$reason"
  else
    rv=0
    p6_test_tap_not_ok "$description" "$reason"
    p6_test_tap_diagnostic "[$val] is not blank"
  fi

  return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_not_blank(val, description, reason)
#
#  Args:
#	val -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_not_blank() {
  local val="$1"
  local description="$2"
  local reason="$3"

  local rv=-1
  if [ -n "$val" ]; then
    rv=1
    p6_test_tap_ok "$description" "$reason"
  else
    rv=0
    p6_test_tap_not_ok "$description" "$reason"
    p6_test_tap_diagnostic "[$val] is blank"
  fi

  return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_dir_exists(val, description, reason)
#
#  Args:
#	val -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_dir_exists() {
  local val="$1"
  local description="$2"
  local reason="$3"

  local rv=-1
  if [ -d "$val" ]; then
    rv=1
    p6_test_tap_ok "$description" "$reason"
  else
    rv=0
    p6_test_tap_not_ok "$description" "$reason"
    p6_test_tap_diagnostic "[$val] DNE"
  fi

  return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_dir_not_exists(val, description, reason)
#
#  Args:
#	val -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_dir_not_exists() {
  local val="$1"
  local description="$2"
  local reason="$3"

  local rv=-1
  if [ ! -d "$val" ]; then
    rv=1
    p6_test_tap_ok "$description" "$reason"
  else
    rv=0
    p6_test_tap_not_ok "$description" "$reason"
    p6_test_tap_diagnostic "[$val] exists"
  fi

  return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_file_exists(val, description, reason)
#
#  Args:
#	val -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_file_exists() {
  local val="$1"
  local description="$2"
  local reason="$3"

  local rv=-1
  if [ -f "$val" ]; then
    rv=1
    p6_test_tap_ok "$description" "$reason"
  else
    rv=0
    p6_test_tap_not_ok "$description" "$reason"
    p6_test_tap_diagnostic "[$val] DNE"
  fi

  return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_file_not_exists(val, description, reason)
#
#  Args:
#	val -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_file_not_exists() {
  local val="$1"
  local description="$2"
  local reason="$3"

  local rv=-1
  if [ ! -f "$val" ]; then
    rv=1
    p6_test_tap_ok "$description" "$reason"
  else
    rv=0
    p6_test_tap_not_ok "$description" "$reason"
    p6_test_tap_diagnostic "[$val] exists"
  fi

  return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_file_matches(file1, file2, description, reason)
#
#  Args:
#	file1 -
#	file2 -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_file_matches() {
  local file1="$1"
  local file2="$2"
  local description="$3"
  local reason="$4"

  local rv=-1
  if cmp -s "$file1" "$file2"; then
    rv=1
    p6_test_tap_ok "$description" "$reason"
  else
    rv=0
    local state_dir
    state_dir=$(p6_test_state_locate) || return 1

    local block_dir
    block_dir=$(p6_test_state_get "$state_dir" "block_dir" "")

    diff -u "$file1" "$file2" >"$block_dir/delta.txt"
    p6_test_tap_not_ok "$description" "$reason"
    p6_test_tap_diagnostic "[$file2] differs: $(cat "$block_dir/delta.txt")"
  fi

  return $rv
}
