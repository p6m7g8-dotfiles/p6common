# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "54"

    p6_test_start "p6_return_true"
    (
        p6_test_run "p6_return_true"
        p6_test_assert_run_ok "true"
    )
    p6_test_finish

    p6_test_start "p6_return_false"
    (
        p6_test_run "p6_return_false"
        p6_test_assert_run_rc "false: rc" 1
        p6_test_assert_blank "$(p6_test_run_stdout)" "false: stdout blank"
        p6_test_assert_blank "$(p6_test_run_stderr)" "false: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_return_void"
    (
        p6_test_run "p6_return_void"
        p6_test_assert_run_ok "void"
    )
    p6_test_finish

    p6_test_start "p6_return_bool"
    (
        p6_test_run "p6_return_bool 0"
        p6_test_assert_run_ok "bool 0"
    )
    p6_test_finish

    p6_test_start "p6_return_size_t"
    (
        p6_test_run "p6_return_size_t 5"
        p6_test_assert_run_ok "size_t" 0 "5"
    )
    p6_test_finish

    p6_test_start "p6_return_int"
    (
        p6_test_run "p6_return_int -7"
        p6_test_assert_run_ok "int" 0 "-7"
    )
    p6_test_finish

    p6_test_start "p6_return_float"
    (
        p6_test_run "p6_return_float 1.5"
        p6_test_assert_run_ok "float" 0 "1.5"
    )
    p6_test_finish

    p6_test_start "p6_return_filter"
    (
        p6_test_run "false; p6_return_filter"
        p6_test_assert_run_rc "filter: rc" 1
        p6_test_assert_blank "$(p6_test_run_stdout)" "filter: stdout blank"
        p6_test_assert_blank "$(p6_test_run_stderr)" "filter: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_return_ipv4"
    (
        p6_test_run "p6_return_ipv4 1.2.3.4"
        p6_test_assert_run_ok "ipv4" 0 "1.2.3.4"
    )
    p6_test_finish

    p6_test_start "p6_return_stream"
    (
        p6_test_run "p6_return_stream"
        p6_test_assert_run_ok "stream"
    )
    p6_test_finish

    p6_test_start "p6_return_str"
    (
        p6_test_run "p6_return_str abc"
        p6_test_assert_run_ok "str" 0 "abc"
    )
    p6_test_finish

    p6_test_start "p6_return_path"
    (
        p6_test_run "p6_return_path /tmp/foo"
        p6_test_assert_run_ok "path" 0 "/tmp/foo"
    )
    p6_test_finish

    p6_test_start "p6_return_date"
    (
        p6_test_run "p6_return_date 2024-01-02"
        p6_test_assert_run_ok "date" 0 "2024-01-02"
    )
    p6_test_finish

    p6_test_start "p6_return_words"
    (
        p6_test_run "p6_return_words a b"
        p6_test_assert_run_ok "words" 0 "a b"
    )
    p6_test_finish

    p6_test_start "p6_return_code_as_code"
    (
        p6_test_run "p6_return_code_as_code 7"
        p6_test_assert_run_rc "code_as_code: rc" 7
        p6_test_assert_blank "$(p6_test_run_stdout)" "code_as_code: stdout blank"
        p6_test_assert_blank "$(p6_test_run_stderr)" "code_as_code: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_return_code_as_value"
    (
        p6_test_run "p6_return_code_as_value 7"
        p6_test_assert_run_ok "code_as_value" 0 "7"
    )
    p6_test_finish

    p6_test_start "p6_return"
    (
        p6_test_run "p6_return ok"
        p6_test_assert_run_ok "return" 0 "ok"
    )
    p6_test_finish

    p6_test_start "p6_return_code__validate"
    (
        p6_test_run "rc=7; p6_return_code__validate"
        p6_test_assert_run_ok "validate"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
