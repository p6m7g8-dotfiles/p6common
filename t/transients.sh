# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "30"

    p6_test_start "p6_transient__debug"
    (
        p6_test_run "p6_transient__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_transient_create"
    (
        local base=$(pwd)
        p6_test_run "P6_DIR_TRANSIENTS=$base/transients; P6_TRANSIENT_LOG=$base/transients.log; P6_TEST_TRANSIENT_CREATE_RAND=1; p6_transient_create foo"
        p6_test_assert_run_ok "create" 0 "$base/transients/foo/TEST_MODE"
    )
    p6_test_finish

    p6_test_start "p6_transient_create_file"
    (
        local base=$(pwd)
        p6_test_run "P6_DIR_TRANSIENTS=$base/transients; P6_TRANSIENT_LOG=$base/transients.log; P6_TEST_TRANSIENT_CREATE_RAND=1; p6_transient_create_file bar"
        p6_test_assert_run_ok "create_file" 0 "$base/transients/bar/TEST_MODE/file"
    )
    p6_test_finish

    p6_test_start "p6_transient_is"
    (
        local base=$(pwd)
        p6_test_run "P6_DIR_TRANSIENTS=$base/transients; P6_TRANSIENT_LOG=$base/transients.log; P6_TEST_TRANSIENT_CREATE_RAND=1; dir=\$(p6_transient_create foo); p6_transient_is \"\$dir\""
        p6_test_assert_run_ok "is"
    )
    p6_test_finish

    p6_test_start "p6_transient_persist"
    (
        local base=$(pwd)
        p6_test_run "P6_DIR_TRANSIENTS=$base/transients; P6_TRANSIENT_LOG=$base/transients.log; P6_TEST_TRANSIENT_CREATE_RAND=1; dir=\$(p6_transient_create foo); p6_transient_persist \"\$dir\""
        p6_test_assert_run_rc "persist: rc" 0
        p6_test_assert_file_exists "$base/transients/foo/TEST_MODE/persist" "persist: file exists"
        p6_test_assert_blank "$(p6_test_run_stderr)" "persist: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_transient_persist_un"
    (
        local base=$(pwd)
        p6_test_run "P6_DIR_TRANSIENTS=$base/transients; P6_TRANSIENT_LOG=$base/transients.log; P6_TEST_TRANSIENT_CREATE_RAND=1; dir=\$(p6_transient_create foo); p6_transient_persist \"\$dir\"; p6_transient_persist_un \"\$dir\""
        p6_test_assert_run_rc "persist_un: rc" 0
        p6_test_assert_file_not_exists "$base/transients/foo/TEST_MODE/persist" "persist_un: removed"
        p6_test_assert_blank "$(p6_test_run_stderr)" "persist_un: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_transient_persist_is"
    (
        local base=$(pwd)
        p6_test_run "P6_DIR_TRANSIENTS=$base/transients; P6_TRANSIENT_LOG=$base/transients.log; P6_TEST_TRANSIENT_CREATE_RAND=1; dir=\$(p6_transient_create foo); p6_transient_persist \"\$dir\"; p6_transient_persist_is \"\$dir\""
        p6_test_assert_run_rc "persist_is: rc" 0
        p6_test_assert_blank "$(p6_test_run_stdout)" "persist_is: stdout blank"
        p6_test_assert_blank "$(p6_test_run_stderr)" "persist_is: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_transient_delete"
    (
        local base=$(pwd)
        p6_test_run "P6_DIR_TRANSIENTS=$base/transients; P6_TRANSIENT_LOG=$base/transients.log; P6_TEST_TRANSIENT_CREATE_RAND=1; dir=\$(p6_transient_create foo); p6_transient_delete \"\$dir\""
        p6_test_assert_run_rc "delete: rc" 0
        p6_test_assert_dir_not_exists "$base/transients/foo/TEST_MODE" "delete: dir removed"
        p6_test_assert_blank "$(p6_test_run_stderr)" "delete: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_transient__log"
    (
        local base=$(pwd)
        p6_test_run "P6_TRANSIENT_LOG=$base/transients.log; p6_transient__log /tmp/foo; cat $base/transients.log"
        p6_test_assert_run_ok "log" 0 "/tmp/foo"
    )
    p6_test_finish

    p6_test_start "p6_transient__cleanup"
    (
        local base=$(pwd)
        p6_test_run "P6_DIR_TRANSIENTS=$base/transients; P6_TRANSIENT_LOG=$base/transients.log; mkdir -p $base/transients/foo/TEST_MODE; echo $base/transients/foo/TEST_MODE > $base/transients.log; p6_transient__cleanup"
        p6_test_assert_run_rc "cleanup: rc" 0
        p6_test_assert_dir_not_exists "$base/transients/foo/TEST_MODE" "cleanup: dir removed"
        p6_test_assert_file_not_exists "$base/transients.log" "cleanup: log removed"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
