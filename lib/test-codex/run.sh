# shellcheck shell=zsh

######################################################################
#<
#
# Function: p6_test_run(command, ...)
#
#  Args:
#	command -
#	... -
#
#>
######################################################################
p6_test_run() {
  local command="$1"
  shift 1

  local state_dir
  state_dir=$(p6_test_state_locate) || return 1

  local block_dir
  block_dir=$(p6_test_state_get "$state_dir" "block_dir" "")
  if [ -z "$block_dir" ]; then
    return 1
  fi

  local stdout="$block_dir/stdout"
  local stderr="$block_dir/stderr"
  local rv="$block_dir/rv"
  local cli="$block_dir/cli"

  local args
  args="$*"

  (
    eval "$command $args"
  ) >"$stdout" 2>"$stderr"
  local rc=$?

  printf '%s\n' "$rc" >"$rv"
  printf '%s\n' "$command $args" >"$cli"
}

######################################################################
#<
#
# Function: str = p6_test_run_stdout()
#
#  Returns:
#	str -
#
#>
######################################################################
p6_test_run_stdout() {
  local state_dir
  state_dir=$(p6_test_state_locate) || return 1

  local block_dir
  block_dir=$(p6_test_state_get "$state_dir" "block_dir" "")

  cat "$block_dir/stdout"
}

######################################################################
#<
#
# Function: str = p6_test_run_stderr()
#
#  Returns:
#	str -
#
#>
######################################################################
p6_test_run_stderr() {
  local state_dir
  state_dir=$(p6_test_state_locate) || return 1

  local block_dir
  block_dir=$(p6_test_state_get "$state_dir" "block_dir" "")

  cat "$block_dir/stderr"
}

######################################################################
#<
#
# Function: int = p6_test_run_rc()
#
#  Returns:
#	int -
#
#>
######################################################################
p6_test_run_rc() {
  local state_dir
  state_dir=$(p6_test_state_locate) || return 1

  local block_dir
  block_dir=$(p6_test_state_get "$state_dir" "block_dir" "")

  cat "$block_dir/rv"
}
