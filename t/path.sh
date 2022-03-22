# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "12"

    p6_test_start "p6_path_current"
    (
        local p="/bin:/usr/bin"
        local cmd="PATH=$p p6_path_current"

        p6_test_run "$cmd"

        p6_test_assert_run_rc "min path: rc=0" "0"
        p6_test_assert_eq "$(p6_test_run_stdout | xargs)" "$(echo $p | sed -e 's,:, ,g')" "min path: works"
        p6_test_assert_blank "$(p6_test_run_stderr)" "min path: no stderr"
    )
    p6_test_finish

    p6_test_start "p6_path_if"
    (
        p6_test_run "p6_path_if"
        p6_test_assert_run_ok "no arg" "1"

        p6_test_run "p6_path_if /nonexistent"
        p6_test_assert_run_ok "/nonexistent" "1"

        p6_test_run "PATH=/bin:/usr/bin p6_path_if $P6_TEST_DIR_ORIG/t"
        p6_test_assert_run_ok "$P6_TEST_DIR_ORIG/t" "0"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
