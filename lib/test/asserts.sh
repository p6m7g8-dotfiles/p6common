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
#/ Synopsis
#/    Asserts a command run succeeded and matches optional stdout/stderr.
######################################################################
p6_test_assert_run_ok() {
  local description="$1" # assertion description
  local rv="${2:-0}"      # expected return value
  local stdout="${3:-}"   # expected stdout
  local stderr="${4:-}"   # expected stderr

  p6_test_assert_run_rc "$description: return code success" "$rv"

  if p6_string_blank_NOT "$stdout"; then
    p6_test_assert_eq "$(p6_test_run_stdout)" "$stdout" "$description: custom stdout matches"
  else
    p6_test_assert_run_no_stdout "$description"
  fi

  if p6_string_blank_NOT "$stderr"; then
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
#/ Synopsis
#/    Asserts the last run return code equals rv.
######################################################################
p6_test_assert_run_rc() {
  local description="$1" # assertion description
  local rv="$2"          # expected return value

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
#/ Synopsis
#/    Asserts that the last run produced no stdout or stderr.
######################################################################
p6_test_assert_run_no_output() {
  local description="$1" # assertion description
  local reason="$2"      # failure reason

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
#/ Synopsis
#/    Asserts that the last run produced no stdout.
######################################################################
p6_test_assert_run_no_stdout() {
  local description="$1" # assertion description
  local reason="$2"      # failure reason

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
#/ Synopsis
#/    Asserts that the last run produced no stderr.
######################################################################
p6_test_assert_run_no_stderr() {
  local description="$1" # assertion description
  local reason="$2"      # failure reason

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
#/ Synopsis
#/    Asserts that the last run return code is non-zero.
######################################################################
p6_test_assert_run_not_ok() {
  local description="$1" # assertion description
  local reason="$2"      # failure reason

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
#/ Synopsis
#/    Asserts val equals const and reports diagnostic on mismatch.
######################################################################
p6_test_assert_eq() {
  local val="$1"         # actual value
  local const="$2"       # expected value
  local description="$3" # assertion description
  local reason="$4"      # failure reason

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
#/ Synopsis
#/    Asserts val does not equal const.
######################################################################
p6_test_assert_not_eq() {
  local val="$1"         # actual value
  local const="$2"       # expected value
  local description="$3" # assertion description
  local reason="$4"      # failure reason

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
#/ Synopsis
#/    Asserts the length of val equals const.
######################################################################
p6_test_assert_len() {
  local val="$1"         # actual value
  local const="$2"       # expected length
  local description="$3" # assertion description
  local reason="$4"      # failure reason

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
#/ Synopsis
#/    Asserts val matches the regex const.
######################################################################
p6_test_assert_contains() {
  local val="$1"         # actual value
  local const="$2"       # regex pattern
  local description="$3" # assertion description
  local reason="$4"      # failure reason

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
#/ Synopsis
#/    Asserts val does not match the regex const.
######################################################################
p6_test_assert_not_contains() {
  local val="$1"         # actual value
  local const="$2"       # regex pattern
  local description="$3" # assertion description
  local reason="$4"      # failure reason

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
#/ Synopsis
#/    Asserts val is blank.
######################################################################
p6_test_assert_blank() {
  local val="$1"         # value to check
  local description="$2" # assertion description
  local reason="$3"      # failure reason

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
#/ Synopsis
#/    Asserts val is not blank.
######################################################################
p6_test_assert_not_blank() {
  local val="$1"         # value to check
  local description="$2" # assertion description
  local reason="$3"      # failure reason

  local rv=-1
  if p6_string_blank_NOT "$val"; then
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
#/ Synopsis
#/    Asserts that a directory exists.
######################################################################
p6_test_assert_dir_exists() {
  local val="$1"         # directory path
  local description="$2" # assertion description
  local reason="$3"      # failure reason

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
#/ Synopsis
#/    Asserts that a directory does not exist.
######################################################################
p6_test_assert_dir_not_exists() {
  local val="$1"         # directory path
  local description="$2" # assertion description
  local reason="$3"      # failure reason

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
#/ Synopsis
#/    Asserts that a file exists.
######################################################################
p6_test_assert_file_exists() {
  local val="$1"         # file path
  local description="$2" # assertion description
  local reason="$3"      # failure reason

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
#/ Synopsis
#/    Asserts that a file does not exist.
######################################################################
p6_test_assert_file_not_exists() {
  local val="$1"         # file path
  local description="$2" # assertion description
  local reason="$3"      # failure reason

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
#/ Synopsis
#/    Asserts that two files have identical contents.
######################################################################
p6_test_assert_file_matches() {
  local file1="$1"       # expected file
  local file2="$2"       # actual file
  local description="$3" # assertion description
  local reason="$4"      # failure reason

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

######################################################################
#<
#
# Function: p6_test_assert_log_contains(needle, [log_file=])
#
#  Args:
#	needle -
#	OPTIONAL log_file - []
#
#  Environment:	 P6_PREFIX P6_TEST_LOG_FILE
#>
#/ Synopsis
#/    Asserts that the log file contains the given needle.
######################################################################
p6_test_assert_log_contains() {
  local needle="$1"       # string to search for
  local log_file="${2:-}" # log file path

  if [ -z "$needle" ]; then
    p6_test_tap_not_ok "log contains" "missing needle"
    return 1
  fi

  if [ -z "$log_file" ] && [ -z "$P6_TEST_LOG_FILE" ] && [ -z "$P6_PREFIX" ]; then
    p6_test_tap_skip "log contains [$needle]" "log file not configured"
    return 0
  fi

  local file
  for file in "$log_file" "$P6_TEST_LOG_FILE" "$P6_PREFIX/tmp/p6/debug.log"; do
    if p6_string_blank_NOT "$file" && [ -f "$file" ]; then
      if grep -q -- "$needle" "$file"; then
        p6_test_tap_ok "log contains [$needle]" ""
        return 0
      fi
      p6_test_tap_not_ok "log contains [$needle]" ""
      p6_test_tap_diagnostic "[$file] missing [$needle]"
      return 1
    fi
  done

  p6_test_tap_skip "log contains [$needle]" "log file missing"
  return 0
}
