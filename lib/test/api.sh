# shellcheck shell=bash

#
# #!/bin/sh
#
# p6_test_setup "5"
#
# p6_test_start "running things"
# (
#	p6_test_run "date" "args..."
#	p6_test_assert_run_ok "d1" "r1"
#	p6_test_assert_run_not_ok "d2" "r2"
# )
# p6_test_finish
#
# p6_test_start "directives 1"
# (
#	p6_test_skip "description" "bar" "$code"
#	echo "should not got here"
# )
# p6_test_finish
#
# p6_test_start "directives 2"
# (
#	p6_test_todo "$code" "description" "bar"
# )
#
# p6_test_finish
#
# p6_test_start "asserts"
# (
#     local val=1
#     p6_test_assert_eq        "$val" "1" "description" "reason"
#     p6_test_assert_eq        "$val" "0" "description"
#     p6_test_diagnostic       "expected [$val], got [0]"
#     p6_test_bail "gtfo"
#
#     p6_test_assert_contains   "$val" "const" "description" "reason"
#     p6_test_assert_blank      "$val" "description" "reason"
#     p6_test_assert_not_blank  "$val" "description" "reason"
# )
# p6_test_finish
#
# p6_test_start "should not run"
# (
#	local val=1
#	p6_test_assert_eq        "$val" "1" "description" "reason"
# )
# p6_test_finish
#
# p6_test_teardown
#
######################################################################
#<
#
# Function: p6_test_setup(n)
#
#  Args:
#	n -
#
#  Depends:	 p6_test
#>
######################################################################
p6_test_setup() {
    local n="$1"

    p6_test__initialize "$n"
    p6_test_tap_plan "$n"
}

######################################################################
#<
#
# Function: p6_test_start(block)
#
#  Args:
#	block -
#
#  Depends:	 p6_test
#>
######################################################################
p6_test_start() {
    local block="$1"

    p6_test__prep
    p6_test_tap_block "$block"
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
#  Depends:	 p6_test
#>
######################################################################
p6_test_skip() {
    local description="$1"
    local reason="$2"

    p6_test_tap_skip "$description" "$reason"
    exit 0
}

######################################################################
#<
#
# Function: p6_test_ok(description)
#
#  Args:
#	description -
#
#  Depends:	 p6_test
#>
######################################################################
p6_test_ok() {
    local description="$1"

    p6_test_tap_ok "$description"
}

######################################################################
#<
#
# Function: p6_test_not_ok(description)
#
#  Args:
#	description -
#
#  Depends:	 p6_test
#>
######################################################################
p6_test_not_ok() {
    local description="$1"

    p6_test_tap_not_ok "$description"
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
#  Depends:	 p6_test
#>
######################################################################
p6_test_todo() {
    local val="$1"
    local const="$2"
    local description="$3"
    local reason="$4"

    if [ x"$val" = x"$const" ]; then
	p6_test_tap_todo_bonus "$description" "$reason"
    else
	p6_test_tap_todo_planned "$description" "$reason"
	p6_test_diagnostic "expected [$const], received [$val]"
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
#  Depends:	 p6_test
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
#  Depends:	 p6_test
#>
######################################################################
p6_test_bail() {
    local reason="$1"

    p6_test__bailout
    p6_test_tap_bail_out "$reason"
}

######################################################################
#<
#
# Function: p6_test_finish()
#
#  Depends:	 p6_test
#>
######################################################################
p6_test_finish() {

    if p6_test__cleanup; then
	exit 1
    fi
}

######################################################################
#<
#
# Function: p6_test_teardown()
#
#  Environment:	 P6_TEST_DIR
#>
######################################################################
p6_test_teardown() {

    true
    #rm -rf $P6_TEST_DIR
}
