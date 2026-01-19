# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "9"

    p6_test_start "p6_uri__debug"
    (
        p6_test_run "p6_uri__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_uri_name"
    (
        p6_test_run "p6_uri_name /tmp/example.txt"
        p6_test_assert_run_ok "name" 0 "example.txt"
    )
    p6_test_finish

    p6_test_start "p6_uri_path"
    (
        p6_test_run "p6_uri_path /tmp/example.txt"
        p6_test_assert_run_ok "path" 0 "/tmp"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
