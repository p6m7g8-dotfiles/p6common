# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "18"

    p6_test_start "p6_openssl__debug"
    (
        p6_test_run "p6_openssl__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_openssl_certificate_create"
    (
        p6_test_skip "requires openssl setup" "p6_openssl_certificate_create"
    )
    p6_test_finish

    p6_test_start "p6_openssl_version"
    (
        p6_test_skip "requires openssl" "p6_openssl_version"
    )
    p6_test_finish

    p6_test_start "p6_openssl_req_cert_self_signed_create"
    (
        p6_test_skip "requires openssl setup" "p6_openssl_req_cert_self_signed_create"
    )
    p6_test_finish

    p6_test_start "p6_openssl_ciphers"
    (
        p6_test_skip "requires openssl" "p6_openssl_ciphers"
    )
    p6_test_finish

    p6_test_start "p6_openssl_s_client_connect"
    (
        p6_test_skip "requires network access" "p6_openssl_s_client_connect"
    )
    p6_test_finish

    p6_test_start "p6_openssl_not_after"
    (
        p6_test_skip "requires network access" "p6_openssl_not_after"
    )
    p6_test_finish

    p6_test_start "p6_openssl_not_before"
    (
        p6_test_skip "requires network access" "p6_openssl_not_before"
    )
    p6_test_finish

    p6_test_start "p6_openssl_serial"
    (
        p6_test_skip "requires network access" "p6_openssl_serial"
    )
    p6_test_finish

    p6_test_start "p6_openssl_subject"
    (
        p6_test_skip "requires network access" "p6_openssl_subject"
    )
    p6_test_finish

    p6_test_start "p6_openssl_purpose"
    (
        p6_test_skip "requires network access" "p6_openssl_purpose"
    )
    p6_test_finish

    p6_test_start "p6_openssl_not_purpose"
    (
        p6_test_skip "requires network access" "p6_openssl_not_purpose"
    )
    p6_test_finish

    p6_test_start "p6_openssl_alias"
    (
        p6_test_skip "requires network access" "p6_openssl_alias"
    )
    p6_test_finish

    p6_test_start "p6_openssl_alt_name"
    (
        p6_test_skip "requires network access" "p6_openssl_alt_name"
    )
    p6_test_finish

    p6_test_start "p6_openssl_req_csr_create"
    (
        p6_test_skip "requires openssl setup" "p6_openssl_req_csr_create"
    )
    p6_test_finish

    p6_test_start "p6_openssl_s_server_run"
    (
        p6_test_skip "requires network access" "p6_openssl_s_server_run"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
