# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cicd__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emits a debug message scoped to CI/CD helpers.
######################################################################
p6_cicd__debug() {
    local msg="$1" # debug message

    p6_debug "p6_cicd: $msg"
}

######################################################################
#<
#
# Function: p6_cicd_tests_run(target)
#
#  Args:
#	target - test target name
#
#>
#/ Synopsis
#/    Runs tests for a specific target or auto-detects bats vs t.
######################################################################
p6_cicd_tests_run() {
    local target="$1" # test target name

    if p6_string_blank_NOT "$target"; then
      p6_test_harness_tests_run "$target"
      return $?
    fi

    if p6_dir_exists "bats"; then
      p6_test_harness_tests_run "bats"
    else
      p6_test_harness_tests_run "t"
    fi
}

######################################################################
#<
#
# Function: p6_cicd_test_benchmark()
#
#>
#/ Synopsis
#/    Runs the test benchmark with the provided arguments.
######################################################################
p6_cicd_test_benchmark() {

    p6_test_bench "$@"
}
