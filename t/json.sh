#!/bin/sh

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    . ../p6test/lib/_bootstrap.sh
    p6_p6test_bootstrap "../p6test"

    p6_test_setup "3"

    p6_test_start "p6_colors"
    (
	p6_test_run "false"
	p6_test_assert_run_ok "none"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"