# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "23"

    p6_test_start "p6_ssh__debug"
    (
        p6_test_run "p6_ssh__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_ssh_key_make"
    (
        p6_test_run "p6_ssh_key_make key >/dev/null 2>&1"
        p6_test_assert_run_rc "key_make: rc" 0
        p6_test_assert_file_exists "key" "key_make: priv exists"
        p6_test_assert_file_exists "key.pub" "key_make: pub exists"
    )
    p6_test_finish

    p6_test_start "p6_ssh_key_pub_from_priv"
    (
        p6_test_run "p6_ssh_key_make key >/dev/null 2>&1; p6_ssh_key_pub_from_priv key key2.pub"
        p6_test_assert_run_rc "pub_from_priv: rc" 0
        p6_test_assert_file_exists "key" "pub_from_priv: priv exists"
        p6_test_assert_file_exists "key2.pub" "pub_from_priv: pub exists"
    )
    p6_test_finish

    p6_test_start "p6_ssh_key_check"
    (
        p6_test_run "p6_ssh_key_make key >/dev/null 2>&1; p6_ssh_key_check key key.pub"
        p6_test_assert_run_rc "key_check: rc" 0
        p6_test_assert_blank "$(p6_test_run_stdout)" "key_check: stdout blank"
        p6_test_assert_blank "$(p6_test_run_stderr)" "key_check: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_ssh_key_fingerprint"
    (
        p6_test_run "p6_ssh_key_make key >/dev/null 2>&1; p6_ssh_key_fingerprint key.pub"
        p6_test_assert_run_rc "fingerprint: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "fingerprint: stdout"
        p6_test_assert_blank "$(p6_test_run_stderr)" "fingerprint: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_ssh_key_add"
    (
        p6_test_skip "requires ssh-agent" "p6_ssh_key_add"
    )
    p6_test_finish

    p6_test_start "p6_ssh_key_delete"
    (
        p6_test_skip "requires ssh-agent" "p6_ssh_key_delete"
    )
    p6_test_finish

    p6_test_start "p6_ssh_key_remove"
    (
        p6_test_run "p6_ssh_key_make key >/dev/null 2>&1; p6_ssh_key_remove key"
        p6_test_assert_run_rc "key_remove: rc" 0
        p6_test_assert_file_not_exists "key" "key_remove: priv removed"
        p6_test_assert_file_not_exists "key.pub" "key_remove: pub removed"
    )
    p6_test_finish

    p6_test_start "p6_ssh_keys_chmod"
    (
        p6_test_run "mkdir -p keys; p6_ssh_key_make keys/key >/dev/null 2>&1; p6_ssh_keys_chmod keys/key"
        p6_test_assert_run_ok "keys_chmod"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
