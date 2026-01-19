# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "15"

    p6_test_start "p6_lang__debug"
    (
        p6_test_run "p6_lang__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_lang_cmd_2_env"
    (
        p6_test_run "p6_lang_cmd_2_env python"
        p6_test_assert_run_ok "cmd_2_env" 0 "py"
    )
    p6_test_finish

    p6_test_start "p6_lang_env_2_cmd"
    (
        p6_test_run "p6_lang_env_2_cmd py"
        p6_test_assert_run_ok "env_2_cmd" 0 "python"
    )
    p6_test_finish

    p6_test_start "p6_lang_system_version"
    (
        p6_test_run "p6_lang_system_version bogus"
        p6_test_assert_run_rc "system_version bogus: rc" 0
        local out="$(p6_test_run_stdout)"
        case "$out" in
        no|sys@*) p6_test_ok "system_version bogus: stdout" ;;
        *) p6_test_not_ok "system_version bogus: stdout"; p6_test_diagnostic "got [$out]" ;;
        esac
        p6_test_assert_blank "$(p6_test_run_stderr)" "system_version bogus: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_lang_version"
    (
        p6_test_run "p6_lang_version bogus"
        p6_test_assert_run_rc "version bogus: rc" 0
        local out="$(p6_test_run_stdout)"
        case "$out" in
        no|sys@*) p6_test_ok "version bogus: stdout" ;;
        *) p6_test_not_ok "version bogus: stdout"; p6_test_diagnostic "got [$out]" ;;
        esac
        p6_test_assert_blank "$(p6_test_run_stderr)" "version bogus: stderr blank"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
