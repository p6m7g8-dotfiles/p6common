# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "6"

    p6_test_start "p6_verbose"
    (
        p6_test_run "P6_VERBOSE=0; p6_verbose 1 quiet"
        p6_test_assert_run_ok "verbose off"

        p6_test_run "P6_VERBOSE=1; p6_verbose 1 loud"
        p6_test_assert_run_ok "verbose on" 0 "loud"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
