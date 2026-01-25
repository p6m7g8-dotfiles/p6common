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
#  Environment:	 ZSH_VERSION
#>
#/ Synopsis
#/    Runs a command, capturing stdout, stderr, rc, and normalized output.
######################################################################
p6_test_run() {
  local command="$1" # command to execute
  shift 1            # command arguments

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

  local full_cmd
  full_cmd="$command $args"

  case " $full_cmd " in
  *" alias "*) ;;
  *) full_cmd="" ;;
  esac

  if [ -n "$full_cmd" ] && [ -s "$stdout" ]; then
    local tmp_stdout
    tmp_stdout="$block_dir/stdout.normalized"

    local line
    while IFS= read -r line; do
      case $line in
      alias\ *) printf '%s\n' "$line" ;;
      [A-Za-z_][A-Za-z0-9_]*=*) printf 'alias %s\n' "$line" ;;
      *) printf '%s\n' "$line" ;;
      esac
    done <"$stdout" >"$tmp_stdout"

    mv "$tmp_stdout" "$stdout"
  fi

  if [ -n "$ZSH_VERSION" ] && [ -s "$stderr" ]; then
    local tmp_stderr
    tmp_stderr="$block_dir/stderr.normalized"

    local line
    while IFS= read -r line; do
      case $line in
      *"shift count must be <= $#") ;;
      *) printf '%s\n' "$line" ;;
      esac
    done <"$stderr" >"$tmp_stderr"

    mv "$tmp_stderr" "$stderr"
  fi

  printf '%s\n' "$rc" >"$rv"
  printf '%s\n' "$command $args" >"$cli"
}

######################################################################
#<
#
# Function: p6_test_run_stdout()
#
#>
#/ Synopsis
#/    Prints stdout from the most recent p6_test_run.
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
# Function: p6_test_run_stderr()
#
#>
#/ Synopsis
#/    Prints stderr from the most recent p6_test_run.
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
# Function: p6_test_run_rc()
#
#>
#/ Synopsis
#/    Prints the return code from the most recent p6_test_run.
######################################################################
p6_test_run_rc() {
  local state_dir
  state_dir=$(p6_test_state_locate) || return 1

  local block_dir
  block_dir=$(p6_test_state_get "$state_dir" "block_dir" "")

  cat "$block_dir/rv"
}
