# shellcheck shell=zsh

######################################################################
#<
#
# Function: p6_test_state_init([base_dir=${TMPDIR:-/tmp])
#
#  Args:
#	OPTIONAL base_dir - [${TMPDIR:-/tmp]
#
#  Environment:	 TMPDIR
#>
#/ Synopsis
#/    Creates a temporary test state directory and prints its path.
######################################################################
p6_test_state_init() {
  local base_dir="${1:-${TMPDIR:-/tmp}}" # base temp directory

  local base
  base="${base_dir%/}"

  local state_dir
  state_dir=$(mktemp -d "$base/p6-test.XXXXXX") || return 1

  printf '%s\n' "$state_dir"
}

######################################################################
#<
#
# Function: p6_test_state_cleanup(state_dir)
#
#  Args:
#	state_dir -
#
#>
#/ Synopsis
#/    Removes a test state directory if it exists.
######################################################################
p6_test_state_cleanup() {
  local state_dir="$1" # state directory

  if [ -n "$state_dir" ] && [ -d "$state_dir" ]; then
    rm -rf "$state_dir"
  fi

  return 0
}

######################################################################
#<
#
# Function: p6_test_state_path(state_dir, key)
#
#  Args:
#	state_dir -
#	key -
#
#>
#/ Synopsis
#/    Builds the path for a state key file.
######################################################################
p6_test_state_path() {
  local state_dir="$1" # state directory
  local key="$2"       # state key

  printf '%s/%s\n' "$state_dir" "$key"
}

######################################################################
#<
#
# Function: p6_test_state_set(state_dir, key, value)
#
#  Args:
#	state_dir -
#	key -
#	value -
#
#>
#/ Synopsis
#/    Writes a state value to its key file.
######################################################################
p6_test_state_set() {
  local state_dir="$1" # state directory
  local key="$2"       # state key
  local value="$3"     # value to store

  printf '%s\n' "$value" >"$(p6_test_state_path "$state_dir" "$key")"
}

######################################################################
#<
#
# Function: p6_test_state_get(state_dir, key, [default=])
#
#  Args:
#	state_dir -
#	key -
#	OPTIONAL default - []
#
#>
#/ Synopsis
#/    Reads a state value, returning default when missing.
######################################################################
p6_test_state_get() {
  local state_dir="$1"   # state directory
  local key="$2"         # state key
  local default="${3:-}" # fallback value

  local file_path
  file_path=$(p6_test_state_path "$state_dir" "$key")

  if [ -f "$file_path" ]; then
    cat "$file_path"
  else
    printf '%s\n' "$default"
  fi
}

######################################################################
#<
#
# Function: p6_test_state_inc(state_dir, key)
#
#  Args:
#	state_dir -
#	key -
#
#>
#/ Synopsis
#/    Increments a numeric state value and prints it.
######################################################################
p6_test_state_inc() {
  local state_dir="$1" # state directory
  local key="$2"       # state key

  local current
  current=$(p6_test_state_get "$state_dir" "$key" "0")
  current=$((current + 1))

  p6_test_state_set "$state_dir" "$key" "$current"
  printf '%s\n' "$current"
}

######################################################################
#<
#
# Function: p6_test_state_mkdir(state_dir, subdir)
#
#  Args:
#	state_dir -
#	subdir -
#
#>
#/ Synopsis
#/    Creates a subdirectory under the state directory.
######################################################################
p6_test_state_mkdir() {
  local state_dir="$1" # state directory
  local subdir="$2"    # subdirectory name

  mkdir -p "$state_dir/$subdir"
  printf '%s/%s\n' "$state_dir" "$subdir"
}

######################################################################
#<
#
# Function: p6_test_state_locate([start_dir=$PWD])
#
#  Args:
#	OPTIONAL start_dir - [$PWD]
#
#  Environment:	 PWD
#>
#/ Synopsis
#/    Locates the nearest .p6-test-state file and prints its path.
######################################################################
p6_test_state_locate() {
  local start_dir="${1:-$PWD}" # search start directory

  local dir="$start_dir"
  while true; do
    if [ -f "$dir/.p6-test-state" ]; then
      cat "$dir/.p6-test-state"
      return 0
    fi
    if [ "$dir" = "/" ] || [ -z "$dir" ]; then
      return 1
    fi
    dir=$(dirname "$dir")
  done
}
