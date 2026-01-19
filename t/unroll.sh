# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "2"

    p6_test_start "p6_unroll_functions"
    (
        p6_test_skip "writes to fpath without setup" "p6_unroll_functions"
    )
    p6_test_finish

    p6_test_start "p6_unroll_function"
    (
        p6_test_skip "depends on external fpath usage" "p6_unroll_function"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
