# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cicd__debug()
#
#>
######################################################################
p6_cicd__debug() {
    local msg="$1"

    p6_debug "p6_cicd: $msg"
}

######################################################################
#<
#
# Function: p6_cicd_tests_run()
#
#>
######################################################################
p6_cicd_tests_run() {

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
######################################################################
p6_cicd_test_benchmark() {

    p6_test_bench "$@"
}
