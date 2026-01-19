# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "18"

    p6_test_start "p6_path__debug"
    (
        p6_test_run "p6_path__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_path_if"
    (
		p6_test_run "PATH=/bin:/usr/bin; p6_path_if .; rc=\$?; printf %s \"\$PATH\"; (exit \$rc)"
		p6_test_assert_run_ok "append" 0 "/bin:/usr/bin:."

		p6_test_run "PATH=/bin:/usr/bin; p6_path_if /nope; rc=\$?; printf %s \"\$PATH\"; (exit \$rc)"
        p6_test_assert_run_rc "dne: rc" 1
        p6_test_assert_eq "$(p6_test_run_stdout)" "/bin:/usr/bin" "dne: PATH unchanged"
        p6_test_assert_blank "$(p6_test_run_stderr)" "dne: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_path_default"
    (
		p6_test_run "path_if() { p6_path_if \"\$@\"; }; p6_path_default"
        p6_test_assert_run_ok "default"
    )
    p6_test_finish

    p6_test_start "p6_path_current"
    (
		p6_test_run "PATH='/bin:/usr/bin:a:b'; p6_path_current | tr '\n' ' ' | sed 's/ $//'"
		p6_test_assert_run_ok "current" 0 "/bin /usr/bin a b"
    )
    p6_test_finish

    p6_test_start "p6_cdpath_current"
    (
		p6_test_run "CDPATH='c:d'; p6_cdpath_current | tr '\n' ' ' | sed 's/ $//'"
		p6_test_assert_run_ok "cdpath current" 0 "c d"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
