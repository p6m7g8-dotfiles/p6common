# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "6"

    p6_test_start "p6_template__debug"
    (
        p6_test_run "p6_template__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_template_process"
    (
        p6_test_run "echo 'Hello NAME' > tmpl.txt; p6_template_process tmpl.txt 'NAME=World'"
        p6_test_assert_run_ok "template_process" 0 "Hello World"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
