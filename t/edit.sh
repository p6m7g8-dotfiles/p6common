# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "4"

    p6_test_start "p6_edit_scratch_file_create"
    (
        p6_test_run "p6_edit_scratch_file_create 'hello world'"
        p6_test_assert_run_rc "scratch: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "scratch: path"
        p6_test_assert_blank "$(p6_test_run_stderr)" "scratch: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_edit_editor_run"
    (
        p6_test_skip "requires interactive editor" "p6_edit_editor_run"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
