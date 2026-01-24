# shellcheck shell=zsh

######################################################################
#<
#
# Function: path = p6_test_state_init([base_dir=${TMPDIR:-/tmp}])
#
#  Args:
#	OPTIONAL base_dir - [${TMPDIR:-/tmp}]
#
#  Returns:
#	path - state dir
#
#  Environment:	 TMPDIR
#>
######################################################################
p6_test_state_init() {
  local base_dir="${1:-${TMPDIR:-/tmp}}"

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
######################################################################
p6_test_state_cleanup() {
  local state_dir="$1"

  if [ -n "$state_dir" ] && [ -d "$state_dir" ]; then
    rm -rf "$state_dir"
  fi

  return 0
}

######################################################################
#<
#
# Function: path = p6_test_state_path(state_dir, key)
#
#  Args:
#	state_dir -
#	key -
#
#  Returns:
#	path -
#
#>
######################################################################
p6_test_state_path() {
  local state_dir="$1"
  local key="$2"

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
######################################################################
p6_test_state_set() {
  local state_dir="$1"
  local key="$2"
  local value="$3"

  printf '%s\n' "$value" >"$(p6_test_state_path "$state_dir" "$key")"
}

######################################################################
#<
#
# Function: str = p6_test_state_get(state_dir, key, [default=])
#
#  Args:
#	state_dir -
#	key -
#	OPTIONAL default - []
#
#  Returns:
#	str -
#
#>
######################################################################
p6_test_state_get() {
  local state_dir="$1"
  local key="$2"
  local default="${3:-}"

  local path
  path=$(p6_test_state_path "$state_dir" "$key")

  if [ -f "$path" ]; then
    cat "$path"
  else
    printf '%s\n' "$default"
  fi
}

######################################################################
#<
#
# Function: int = p6_test_state_inc(state_dir, key)
#
#  Args:
#	state_dir -
#	key -
#
#  Returns:
#	int -
#
#>
######################################################################
p6_test_state_inc() {
  local state_dir="$1"
  local key="$2"

  local current
  current=$(p6_test_state_get "$state_dir" "$key" "0")
  current=$((current + 1))

  p6_test_state_set "$state_dir" "$key" "$current"
  printf '%s\n' "$current"
}

######################################################################
#<
#
# Function: path = p6_test_state_mkdir(state_dir, subdir)
#
#  Args:
#	state_dir -
#	subdir -
#
#  Returns:
#	path -
#
#>
######################################################################
p6_test_state_mkdir() {
  local state_dir="$1"
  local subdir="$2"

  mkdir -p "$state_dir/$subdir"
  printf '%s/%s\n' "$state_dir" "$subdir"
}
