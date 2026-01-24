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
######################################################################
p6_test_tap_plan() {
  local n="$1"

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
######################################################################
p6_test_tap_ok() {
  local description="$1"
  local reason="$2"

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
######################################################################
p6_test_tap_not_ok() {
  local description="$1"
  local reason="$2"

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
######################################################################
p6_test_tap_block() {
  local block="$1"

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
######################################################################
p6_test_tap_skip() {
  local description="$1"
  local reason="$2"

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
######################################################################
p6_test_tap_todo_planned() {
  local description="$1"
  local reason="$2"

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
######################################################################
p6_test_tap_todo_bonus() {
  local description="$1"
  local reason="$2"

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
######################################################################
p6_test_tap_diagnostic() {
  local msg="$1"

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
######################################################################
p6_test_tap_bail_out() {
  local reason="$1"

  printf 'Bail out! %s\n' "$reason"
}

######################################################################
#<
#
# Function: p6_test_tap_shell()
#
#>
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
######################################################################
p6_test_tap__line() {
  local outcome="$1"
  local i="$2"
  local description="$3"
  local directive="$4"
  local reason="$5"

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
# Function: int = p6_test_tap__next_index()
#
#  Returns:
#	int -
#
#>
######################################################################
p6_test_tap__next_index() {
  local state_dir
  state_dir=$(p6_test_state_locate) || return 1

  p6_test_state_inc "$state_dir" "index"
}
