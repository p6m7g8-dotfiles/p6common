# shellcheck shell=zsh

######################################################################
#<
#
# Function: p6_test_tap_plan(n)
#
#  Args:
#	n -
#
#>
#/ Synopsis
#/    Prints a TAP plan line for n tests.
######################################################################
p6_test_tap_plan() {
  local n="$1" # number of planned tests

  printf '1..%s\n' "$n"
}

######################################################################
#<
#
# Function: p6_test_tap_ok(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
#/ Synopsis
#/    Emits a TAP ok line.
######################################################################
p6_test_tap_ok() {
  local description="$1" # test description
  local reason="$2"      # reason or note

  local i
  i=$(p6_test_tap__next_index) || i="?"
  p6_test_tap__line "ok" "$i" "$description" "" "$reason"
}

######################################################################
#<
#
# Function: p6_test_tap_not_ok(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
#/ Synopsis
#/    Emits a TAP not ok line.
######################################################################
p6_test_tap_not_ok() {
  local description="$1" # test description
  local reason="$2"      # failure reason

  local i
  i=$(p6_test_tap__next_index) || i="?"
  p6_test_tap__line "not ok" "$i" "$description" "" "$reason"
}

######################################################################
#<
#
# Function: p6_test_tap_block(block)
#
#  Args:
#	block -
#
#>
#/ Synopsis
#/    Prints a TAP block header comment.
######################################################################
p6_test_tap_block() {
  local block="$1" # block name

  printf '# %s\n' "$block"
}

######################################################################
#<
#
# Function: p6_test_tap_skip(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
#/ Synopsis
#/    Emits a TAP ok line with SKIP directive.
######################################################################
p6_test_tap_skip() {
  local description="$1" # test description
  local reason="$2"      # skip reason

  local i
  i=$(p6_test_tap__next_index) || i="?"
  p6_test_tap__line "ok" "$i" "$description" "SKIP" "$reason"
}

######################################################################
#<
#
# Function: p6_test_tap_todo_planned(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
#/ Synopsis
#/    Emits a TAP TODO line marked as planned.
######################################################################
p6_test_tap_todo_planned() {
  local description="$1" # test description
  local reason="$2"      # TODO reason

  local i
  i=$(p6_test_tap__next_index) || i="?"
  p6_test_tap__line "not ok" "$i" "$description" "TODO" "$reason"
}

######################################################################
#<
#
# Function: p6_test_tap_todo_bonus(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
#/ Synopsis
#/    Emits a TAP TODO line marked as bonus.
######################################################################
p6_test_tap_todo_bonus() {
  local description="$1" # test description
  local reason="$2"      # TODO reason

  local i
  i=$(p6_test_tap__next_index) || i="?"
  p6_test_tap__line "ok" "$i" "$description" "TODO" "$reason"
}

######################################################################
#<
#
# Function: p6_test_tap_diagnostic(msg)
#
#  Args:
#	msg -
#
#>
#/ Synopsis
#/    Emits TAP diagnostic comment lines for the message.
######################################################################
p6_test_tap_diagnostic() {
  local msg="$1" # diagnostic message

  local line
  local IFS=$'\n'
  for line in $msg; do
    printf '# %s\n' "$line"
  done
}

######################################################################
#<
#
# Function: p6_test_tap_bail_out(reason)
#
#  Args:
#	reason -
#
#>
#/ Synopsis
#/    Emits a TAP Bail out! line.
######################################################################
p6_test_tap_bail_out() {
  local reason="$1" # bailout reason

  printf 'Bail out! %s\n' "$reason"
}

######################################################################
#<
#
# Function: p6_test_tap_shell()
#
#>
#/ Synopsis
#/    Placeholder to assert the shell is TAP-capable.
######################################################################
p6_test_tap_shell() {
  true
}

######################################################################
#<
#
# Function: p6_test_tap__line(outcome, i, description, directive, reason)
#
#  Args:
#	outcome -
#	i -
#	description -
#	directive -
#	reason -
#
#>
#/ Synopsis
#/    Formats a TAP result line with optional directive and reason.
######################################################################
p6_test_tap__line() {
  local outcome="$1"     # ok/not ok
  local i="$2"           # test index
  local description="$3" # test description
  local directive="$4"   # SKIP/TODO
  local reason="$5"      # directive reason

  local line="$outcome $i"
  if [ -n "$description" ]; then
    line="$line $description"
    if [ -n "$directive" ]; then
      line="$line # $directive"
      if [ -n "$reason" ]; then
        line="$line $reason"
      fi
    fi
  fi

  printf '%s\n' "$line"
}

######################################################################
#<
#
# Function: p6_test_tap__next_index()
#
#>
#/ Synopsis
#/    Increments and returns the current TAP test index.
######################################################################
p6_test_tap__next_index() {
  local state_dir
  state_dir=$(p6_test_state_locate) || return 1

  p6_test_state_inc "$state_dir" "index"
}
