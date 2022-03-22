# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "7"

    p6_test_start "p6_constants"
    (
        p6_test_assert_eq "$P6_TRUE" "0" "P6_TRUE is 0"
        p6_test_assert_eq "$P6_FALSE" "1" "P6_FALSE is 1"
        p6_test_assert_eq "$P6_RETURN_SUCCESS" "0" "P6_RETURN_SUCCESS is 0"
        p6_test_assert_eq "$P6_RETURN_FAIL" "1" "P6_RETURN_FAIL is 1"
        p6_test_assert_eq "$P6_EXIT_SUCCESS" "0" "P6_EXIT_SUCCESS is 0"
        p6_test_assert_eq "$P6_EXIT_FAIL" "1" "P6_EXIT_FAIL is 1"
        p6_test_assert_eq "$P6_EXIT_ARGS" "2" "P6_EXIT_ARGS is 2"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
