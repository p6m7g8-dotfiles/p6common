# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "21"

    p6_test_start "p6_file_exists"
    (
        p6_test_run "p6_file_exists"
        p6_test_assert_run_ok "no arg: dne" 1

        p6_test_run "p6_file_exists" ""
        p6_test_assert_run_ok "\"\": dne" 1

        p6_test_run "p6_file_exists" ''
        p6_test_assert_run_ok "'': dne" 1

        p6_test_run "p6_file_exists" " "
        p6_test_assert_run_ok "\" \": dne" 1

        p6_test_run "p6_file_exists" "' '"
        p6_test_assert_run_ok "\' \': dne" 1

        p6_test_run "p6_file_exists" "/nonexistent"
        p6_test_assert_run_ok "/nonexistent: dne" 1

        p6_test_run "p6_file_exists" "$P6_TEST_DIR_ORIG/README.md"
        p6_test_assert_run_ok "Test file is -r per"
    )
    p6_test_finish

    p6_test_start "p6_file_load"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_file_move"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_file_copy"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_file_rmf"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_file_unlink"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_file_contains"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_file_line_delete_last"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_file_replace"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_file_display"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_file_create"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_file_write"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_file_append"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_file_ma_sync"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_file_symlink"
    (
        true
    )
    p6_test_finish

    p6_test_start "p6_file_cascade"
    (
        true
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
