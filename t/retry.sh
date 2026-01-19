# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "12"

    p6_test_start "p6_retry__debug"
    (
        p6_test_run "p6_retry__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_retry_delay"
    (
        p6_test_run "p6_sleep() { true; }; p6_retry_delay double 2"
        p6_test_assert_run_ok "delay" 0 "4"
    )
    p6_test_finish

    p6_test_start "p6_retry_delay_doubling"
    (
        p6_test_run "p6_sleep() { true; }; p6_retry_delay_doubling 2"
        p6_test_assert_run_ok "delay doubling" 0 "4"
    )
    p6_test_finish

    p6_test_start "p6_retry_delay_log"
    (
        p6_test_run "p6_sleep() { true; }; p6_retry_delay_log 2"
        p6_test_assert_run_ok "delay log" 0 "2"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
