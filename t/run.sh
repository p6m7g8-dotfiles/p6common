# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "40"

    p6_test_start "p6_run__debug"
    (
        p6_test_run "p6_run__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_run_code"
    (
        p6_test_run "p6_run_code echo hi"
        p6_test_assert_run_ok "run_code" 0 "hi"
    )
    p6_test_finish

    p6_test_start "p6_run_yield"
    (
        p6_test_run "foo() { echo ok; }; p6_run_yield foo"
        p6_test_assert_run_ok "run_yield" 0 "ok"
    )
    p6_test_finish

    p6_test_start "p6_run_read_cmd"
    (
        p6_test_run "p6_run_read_cmd echo read"
        p6_test_assert_run_ok "read_cmd" 0 "read"
    )
    p6_test_finish

    p6_test_start "p6_run_write_cmd"
    (
        p6_test_run "p6_run_write_cmd echo write"
        p6_test_assert_run_ok "write_cmd" 0 "write"
    )
    p6_test_finish

    p6_test_start "p6_run_retry"
    (
        p6_test_skip "retry logic uses unset status" "p6_run_retry"
    )
    p6_test_finish

    p6_test_start "p6_run_parallel"
    (
        p6_test_run "p6_run_parallel 0 1 'a' true"
        p6_test_assert_run_rc "parallel: rc" 0
        p6_test_assert_eq "$(p6_test_run_stdout)" "true [] 'a'" "parallel: stdout"
        p6_test_assert_blank "$(p6_test_run_stderr)" "parallel: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_run_serial"
    (
        p6_test_run "p6_run_serial 'a b' true"
        p6_test_assert_run_ok "serial"
    )
    p6_test_finish

    p6_test_start "p6_run_if_not_in"
    (
        p6_test_run "p6_run_if_not_in foo 'foo bar'"
        p6_test_assert_run_rc "in list: rc" 1
        p6_test_assert_blank "$(p6_test_run_stdout)" "in list: stdout blank"
        p6_test_assert_blank "$(p6_test_run_stderr)" "in list: stderr blank"

        p6_test_run "p6_run_if_not_in foo 'bar baz'"
        p6_test_assert_run_rc "not in list: rc" 1
        p6_test_assert_blank "$(p6_test_run_stdout)" "not in list: stdout blank"
        p6_test_assert_blank "$(p6_test_run_stderr)" "not in list: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_run_script"
    (
        p6_test_run "dir=$(pwd); echo 'echo script-ok' > hello; p6_run_script 'PATH=/bin:/usr/bin' /bin/sh -e hello .sh -- \$dir"
        p6_test_assert_run_ok "run_script" 0 "script-ok"
    )
    p6_test_finish

    p6_test_start "p6_run_if"
    (
        p6_test_run "echo 'echo found' > bar; chmod +x bar; PATH=\"/bin:/usr/bin:.\"; p6_run_if bar"
        p6_test_assert_run_ok "run_if" 0 "found"
    )
    p6_test_finish

    p6_test_start "p6_run_dir"
    (
        local wd=$(pwd)
        p6_test_run "mkdir -p work; p6_run_dir work pwd"
        p6_test_assert_run_ok "run_dir" 0 "$wd/work"
    )
    p6_test_finish

    p6_test_start "p6_run_code_and_result"
    (
        p6_test_run "p6_run_code_and_result 'echo FOO=bar'"
        p6_test_assert_run_rc "code_and_result: rc" 0
        p6_test_assert_blank "$(p6_test_run_stdout)" "code_and_result: stdout blank"
        p6_test_assert_not_blank "$(p6_test_run_stderr)" "code_and_result: stderr"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
