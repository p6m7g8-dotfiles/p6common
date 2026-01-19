# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "2"

    p6_test_start "p6_network_ip_public"
    (
        p6_test_skip "requires network access" "p6_network_ip_public"
    )
    p6_test_finish

    p6_test_start "p6_network_file_download"
    (
        p6_test_skip "requires network access" "p6_network_file_download"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
