# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "1"

    p6_test_start "p6_diagnostics"
    (
        p6_test_skip "non-deterministic environment output" "p6_diagnostics"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
