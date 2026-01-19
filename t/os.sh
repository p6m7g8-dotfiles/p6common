# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "6"

    p6_test_start "p6_os__debug"
    (
        p6_test_run "p6_os__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_os_name"
    (
        p6_test_run "p6_os_name"
        p6_test_assert_run_rc "os_name: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "os_name: stdout"
        p6_test_assert_blank "$(p6_test_run_stderr)" "os_name: stderr blank"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
