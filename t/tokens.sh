# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "24"

    p6_test_start "p6_token__debug"
    (
        p6_test_run "p6_token__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

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

    p6_test_start "p6_token_sha256()"
    (
        p6_test_run "p6_token_sha256 foo | tr -d \"$P6_NL\""
        p6_test_assert_run_ok "sha256 foo" 0 "2c26b46b68ffc68ff99b453c1d30413413422d706483bfa0f98a5e886266e7ae"
    )
    p6_test_finish

    p6_test_start "p6_token_encode_base64()"
    (
        p6_test_run "p6_token_encode_base64 foo | tr -d \"$P6_NL\""
        p6_test_assert_run_ok "base64 foo" 0 "Zm9v"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
