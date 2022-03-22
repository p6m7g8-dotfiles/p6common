# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "15"

    p6_test_start "p6_token_hash"
    (
        p6_test_run "p6_token_hash"
        p6_test_assert_run_ok "no arg: needs str=string"

        p6_test_run "p6_token_hash 'foo'"
        p6_test_assert_blank "$(p6_test_run_stderr)" "no stderr"
        p6_test_assert_eq "$(p6_test_run_stdout)" "d3b07384d113edec49eaa6238ad5ff00" "expected hash"
    )
    p6_test_finish

    p6_test_start "p6_token_random()"
    (
        p6_test_run "p6_token_random"
        p6_test_assert_run_ok "no arg"

        p6_test_run "p6_token_random 64"
        p6_test_assert_contains "$(p6_test_run_stdout)" "[0-9a-zA-Z]*" "well formed token"
        p6_test_assert_len "$(p6_test_run_stdout)" "64" "correct length"
    )
    p6_test_finish

    p6_test_start "p6_token_passwd()"
    (
        p6_test_run "p6_token_passwd"
        p6_test_assert_run_ok "no arg"

        p6_test_run "p6_token_passwd 64"
        p6_test_assert_contains "$(p6_test_run_stdout)" "[0-9a-zA-Z]*" "well formed passwd"
        p6_test_assert_len "$(p6_test_run_stdout)" "64" "correct length"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
