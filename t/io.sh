# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "51"

    p6_test_start "p6_echo"
    (
        p6_test_run "p6_echo hello"
        p6_test_assert_run_ok "echo" 0 "hello"
    )
    p6_test_finish

    p6_test_start "p6_msg"
    (
        p6_test_run "p6_msg hello"
        p6_test_assert_run_ok "msg" 0 "hello"
    )
    p6_test_finish

    p6_test_start "p6_msg_no_nl"
    (
        p6_test_run "p6_msg_no_nl hello"
        p6_test_assert_run_rc "msg no nl: rc" 0
        local out="$(p6_test_run_stdout)"
        case "$out" in
        "hello"|"-n hello") p6_test_ok "msg no nl: stdout" ;;
        *) p6_test_not_ok "msg no nl: stdout"; p6_test_diagnostic "got [$out]" ;;
        esac
        p6_test_assert_blank "$(p6_test_run_stderr)" "msg no nl: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_msg_h3"
    (
        p6_test_run "p6_msg_h3 header"
        p6_test_assert_run_ok "msg h3" 0 "======> header"
    )
    p6_test_finish

    p6_test_start "p6_msg_success"
    (
        p6_test_run "p6_msg_success ok"
        p6_test_assert_run_ok "msg success" 0 "✅: ok"
    )
    p6_test_finish

    p6_test_start "p6_msg_fail"
    (
        p6_test_run "p6_msg_fail nope"
        p6_test_assert_run_ok "msg fail" 0 "❌: nope"
    )
    p6_test_finish

    p6_test_start "p6_error"
    (
        p6_test_run "p6_error oops"
        p6_test_assert_run_ok "error" 0 "" "oops"
    )
    p6_test_finish

    p6_test_start "p6_die"
    (
        p6_test_run "(p6_die 7 boom)"
        p6_test_assert_run_rc "die: rc" 7
        p6_test_assert_eq "$(p6_test_run_stdout)" "boom" "die: stdout"
        p6_test_assert_blank "$(p6_test_run_stderr)" "die: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6__header"
    (
        p6_test_run "p6__header 4 head"
        p6_test_assert_run_ok "header" 0 "====> head"
    )
    p6_test_finish

    p6_test_start "p6__deprecated"
    (
        p6_test_run "p6__deprecated old"
        p6_test_assert_run_ok "deprecated" 0 "DEPRECATED: old"
    )
    p6_test_finish

    p6_test_start "p6_h1"
    (
        p6_test_run "p6_h1 one"
        p6_test_assert_run_ok "h1" 0 "==> one"
    )
    p6_test_finish

    p6_test_start "p6_h2"
    (
        p6_test_run "p6_h2 two"
        p6_test_assert_run_ok "h2" 0 "====> two"
    )
    p6_test_finish

    p6_test_start "p6_h3"
    (
        p6_test_run "p6_h3 three"
        p6_test_assert_run_ok "h3" 0 "======> three"
    )
    p6_test_finish

    p6_test_start "p6_h4"
    (
        p6_test_run "p6_h4 four"
        p6_test_assert_run_ok "h4" 0 "========> four"
    )
    p6_test_finish

    p6_test_start "p6_h5"
    (
        p6_test_run "p6_h5 five"
        p6_test_assert_run_ok "h5" 0 "==========> five"
    )
    p6_test_finish

    p6_test_start "p6_h6"
    (
        p6_test_run "p6_h6 six"
        p6_test_assert_run_ok "h6" 0 "============> six"
    )
    p6_test_finish

    p6_test_start "p6_vertical"
    (
        p6_test_run "p6_vertical a:b:c | tr '\n' ' ' | sed 's/ $//'"
        p6_test_assert_run_ok "vertical" 0 "a b c"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
