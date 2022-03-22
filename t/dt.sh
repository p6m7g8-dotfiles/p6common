# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "8"

    p6_test_start "p6_dt_now_epoch_seconds()"
    (
        p6_test_run "p6_dt_now_epoch_seconds"
        p6_test_assert_blank "$(p6_test_run_stderr)" "no stderr"
        p6_test_assert_contains "$(p6_test_run_stdout)" "1[0-9]*" "epoch seconds"
    )
    p6_test_finish

    p6_test_start "p6_dt_now()"
    (
        p6_test_run "p6_dt_now"
        p6_test_assert_blank "$(p6_test_run_stderr)" "no stderr"
        p6_test_assert_contains "$(p6_test_run_stdout)" "20[1-9][0-9][0-9][0-9][0-9][0-9]" "ymd"
    )
    p6_test_finish

    p6_test_start "p6_dt_yesterday()"
    (
        p6_test_run "p6_dt_yesterday"
        p6_test_assert_blank "$(p6_test_run_stderr)" "no stderr"
        p6_test_assert_contains "$(p6_test_run_stdout)" "20[1-9][0-9][0-9][0-9][0-9][0-9]" "ymd"
    )
    p6_test_finish

    p6_test_start "p6_dt_tomorrow()"
    (
        p6_test_run "p6_dt_tomorrow"
        p6_test_assert_blank "$(p6_test_run_stderr)" "no stderr"
        p6_test_assert_contains "$(p6_test_run_stdout)" "20[1-9][0-9][0-9][0-9][0-9][0-9]" "ymd"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
