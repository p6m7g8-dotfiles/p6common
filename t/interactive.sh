# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "1"

    p6_test_start "p6_int_confirm_ask"
    (
        p6_test_skip "p6test doesn't yet do stdin" "future"
        p6_test_run "p6_int_confirm_ask"
        p6_test_assert_run_ok "A: " 42
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
