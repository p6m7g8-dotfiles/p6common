# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "15"

    p6_test_start "p6_env__debug"
    (
        p6_test_run "p6_env__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_env_export"
    (
        p6_test_run "p6_env_export FOO bar; printf %s \"\$FOO\""
        p6_test_assert_run_ok "export" 0 "bar"
    )
    p6_test_finish

    p6_test_start "p6_env_export_un"
    (
        p6_test_run "FOO=bar; export FOO; p6_env_export_un FOO; printf %s \"\${FOO:-}\""
        p6_test_assert_run_ok "export_un"
    )
    p6_test_finish

    p6_test_start "p6_env_list"
    (
        p6_test_run "P6_TEST_ENV_UNIQUE=bar; export P6_TEST_ENV_UNIQUE; p6_env_list '^P6_TEST_ENV_UNIQUE='"
        p6_test_assert_run_ok "env_list" 0 "P6_TEST_ENV_UNIQUE=bar"
    )
    p6_test_finish

    p6_test_start "p6_env_list_p6"
    (
        p6_test_run "P6_TEST_ENV=1; export P6_TEST_ENV; p6_env_list_p6 | p6_filter_row_select_regex '^P6_TEST_ENV=1$'"
        p6_test_assert_run_ok "env_list_p6" 0 "P6_TEST_ENV=1"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
