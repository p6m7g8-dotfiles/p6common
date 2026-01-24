# shellcheck shell=zsh

######################################################################
#<
#
# Function: p6_test_setup(n)
#
#  Args:
#	n -
#
#>
######################################################################
p6_test_setup() {
  local n="$1"

  if [ -n "$ZSH_VERSION" ]; then
    setopt SH_WORD_SPLIT
  fi

  local state_dir
  state_dir=$(p6_test_state_init) || return 1

  printf '%s\n' "$state_dir" >".p6-test-state"

  P6_TEST_DIR_ORIG="${P6_TEST_DIR_ORIG:-$PWD}"

  p6_test_state_set "$state_dir" "plan" "$n"
  p6_test_state_set "$state_dir" "index" "0"
  p6_test_state_set "$state_dir" "bail" "0"
  p6_test_state_set "$state_dir" "orig_dir" "$PWD"

  p6_test_tap_plan "$n"

  return 0
}

######################################################################
#<
#
# Function: p6_test_start(block)
#
#  Args:
#	block -
#
#>
######################################################################
p6_test_start() {
  local block="$1"

  local state_dir
  state_dir=$(p6_test_state_locate) || return 1

  local block_index
  block_index=$(p6_test_state_inc "$state_dir" "block_index")

  local block_dir
  block_dir=$(p6_test_state_mkdir "$state_dir" "block-$block_index") || return 1

  p6_test_state_set "$state_dir" "block_dir" "$block_dir"
  p6_test_state_set "$state_dir" "block_orig" "$PWD"
  p6_test_state_set "$state_dir" "block_name" "$block"

  printf '%s\n' "$state_dir" >"$block_dir/.p6-test-state"

  if [ -d "$PWD/fixtures" ]; then
    cp -R "$PWD/fixtures" "$block_dir/" || return 1
  fi

  cd "$block_dir" || return 1

  p6_test_tap_block "$block"

  return 0
}

######################################################################
#<
#
# Function: p6_test_finish()
#
#>
######################################################################
p6_test_finish() {
  local state_dir
  state_dir=$(p6_test_state_locate) || return 1

  local block_orig
  block_orig=$(p6_test_state_get "$state_dir" "block_orig" "")

  local block_dir
  block_dir=$(p6_test_state_get "$state_dir" "block_dir" "")

  if [ -n "$block_orig" ]; then
    cd "$block_orig" || return 1
  fi

  if [ -n "$block_dir" ] && [ -d "$block_dir" ]; then
    rm -rf "$block_dir"
  fi

  p6_test_state_set "$state_dir" "block_dir" ""
  p6_test_state_set "$state_dir" "block_orig" ""
  p6_test_state_set "$state_dir" "block_name" ""

  local bail
  bail=$(p6_test_state_get "$state_dir" "bail" "0")

  if [ "$bail" -ne 0 ]; then
    return 1
  fi

  return 0
}

######################################################################
#<
#
# Function: p6_test_teardown()
#
#>
######################################################################
p6_test_teardown() {
  local state_dir
  state_dir=$(p6_test_state_locate) || return 0

  local block_orig
  block_orig=$(p6_test_state_get "$state_dir" "block_orig" "")

  if [ -n "$block_orig" ]; then
    cd "$block_orig" || true
  fi

  local block_dir
  block_dir=$(p6_test_state_get "$state_dir" "block_dir" "")
  if [ -n "$block_dir" ] && [ -d "$block_dir" ]; then
    rm -rf "$block_dir"
  fi

  local plan
  plan=$(p6_test_state_get "$state_dir" "plan" "0")

  local index
  index=$(p6_test_state_get "$state_dir" "index" "0")

  if [ "$plan" -ne 0 ] && [ "$plan" -ne "$index" ]; then
    p6_test_tap_diagnostic "planned $plan tests but ran $index"
  fi

  p6_test_state_cleanup "$state_dir"
  rm -f ".p6-test-state"

  return 0
}

######################################################################
#<
#
# Function: p6_test_skip(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
######################################################################
p6_test_skip() {
  local description="$1"
  local reason="$2"

  p6_test_tap_skip "$description" "$reason"
}

######################################################################
#<
#
# Function: p6_test_ok(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
######################################################################
p6_test_ok() {
  local description="$1"
  local reason="$2"

  p6_test_tap_ok "$description" "$reason"
}

######################################################################
#<
#
# Function: p6_test_not_ok(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
######################################################################
p6_test_not_ok() {
  local description="$1"
  local reason="$2"

  p6_test_tap_not_ok "$description" "$reason"
}

######################################################################
#<
#
# Function: p6_test_todo(val, const, description, reason)
#
#  Args:
#	val -
#	const -
#	description -
#	reason -
#
#>
######################################################################
p6_test_todo() {
  local val="$1"
  local const="$2"
  local description="$3"
  local reason="$4"

  if [ "$val" = "$const" ]; then
    p6_test_tap_todo_bonus "$description" "$reason"
  else
    p6_test_tap_todo_planned "$description" "$reason"
    p6_test_tap_diagnostic "expected [$const], received [$val]"
  fi
}

######################################################################
#<
#
# Function: p6_test_diagnostic(msg)
#
#  Args:
#	msg -
#
#>
######################################################################
p6_test_diagnostic() {
  local msg="$1"

  p6_test_tap_diagnostic "$msg"
}

######################################################################
#<
#
# Function: p6_test_bail(reason)
#
#  Args:
#	reason -
#
#>
######################################################################
p6_test_bail() {
  local reason="$1"

  local state_dir
  state_dir=$(p6_test_state_locate) || return 1

  p6_test_state_set "$state_dir" "bail" "1"
  p6_test_tap_bail_out "$reason"
}
