# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "0"

    p6_test_start "p6_echo"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_msg"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_error"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_die"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_h1"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_h2"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_h3"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_h4"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_h5"
    (
        true
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
