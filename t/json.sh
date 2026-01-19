# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "9"

    p6_test_start "p6_json__debug"
    (
        p6_test_run "p6_json__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_json_eval"
    (
        p6_test_run "p6_json_eval '{\"a\":1}' '.a'"
        p6_test_assert_run_ok "eval" 0 "1"
    )
    p6_test_finish

    p6_test_start "p6_json_from_file"
    (
        echo '{"b":2}' > data.json
        p6_test_run "p6_json_from_file data.json | tr -d ' \n'"
        p6_test_assert_run_ok "from_file" 0 "{\"b\":2}"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
