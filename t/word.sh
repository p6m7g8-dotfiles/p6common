# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "15"

    p6_test_start "p6_word__debug"
    (
        p6_test_run "p6_word__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_word_unique"
    (
        p6_test_run "p6_word_unique 'a b a'"
        p6_test_assert_run_ok "unique" 0 "a
b"
    )
    p6_test_finish

    p6_test_start "p6_word_not"
    (
        p6_test_run "p6_word_not 'a b c' 'b'"
        p6_test_assert_run_ok "not" 0 "a
c"
    )
    p6_test_finish

    p6_test_start "p6_word_in"
    (
        p6_test_run "p6_word_in a 'a b'"
        p6_test_assert_run_ok "in list"

        p6_test_run "p6_word_in z 'a b'"
        p6_test_assert_run_rc "not in list: rc" 1
        p6_test_assert_blank "$(p6_test_run_stdout)" "not in list: stdout blank"
        p6_test_assert_blank "$(p6_test_run_stderr)" "not in list: stderr blank"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
