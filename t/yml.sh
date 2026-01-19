# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "5"

    p6_test_start "p6_yml__debug"
    (
        p6_test_run "p6_yml__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_yml_eval"
    (
        p6_test_skip "requires yq" "p6_yml_eval"
    )
    p6_test_finish

    p6_test_start "p6_yml_from_file"
    (
        p6_test_skip "requires yq" "p6_yml_from_file"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
