# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "7"

    p6_test_start "p6_int__debug"
    (
        p6_test_run "p6_int__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_int_confirm_ask"
    (
        p6_test_run "printf \"Y${P6_NL}\" | p6_int_confirm_ask"
        p6_test_assert_run_rc "confirm: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "confirm: prompt"
        p6_test_assert_blank "$(p6_test_run_stderr)" "confirm: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_int_password_read"
    (
        p6_test_skip "requires a tty" "p6_int_password_read"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
