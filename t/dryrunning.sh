# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "6"

    p6_test_start "p6_dryrunning"
    (
        p6_test_run "unset P6_DRY_RUN; p6_dryrunning"
        p6_test_assert_run_rc "dryrunning off: rc" 1
        p6_test_assert_blank "$(p6_test_run_stdout)" "dryrunning off: stdout blank"
        p6_test_assert_blank "$(p6_test_run_stderr)" "dryrunning off: stderr blank"

        p6_test_run "P6_DRY_RUN=1; p6_dryrunning"
        p6_test_assert_run_rc "dryrunning on: rc" 0
        p6_test_assert_blank "$(p6_test_run_stdout)" "dryrunning on: stdout blank"
        p6_test_assert_blank "$(p6_test_run_stderr)" "dryrunning on: stderr blank"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
