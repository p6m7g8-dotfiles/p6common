# shellcheck shell=bash

main() {

	. ../p6common/lib/_bootstrap.sh
	p6_bootstrap "../p6common"

	p6_test_setup "33"

	p6_test_start "p6_string_blank"
	(
		p6_test_run "p6_string_blank"
		p6_test_assert_run_ok "no arg: blank"

		p6_test_run "p6_string_blank" ""
		p6_test_assert_run_ok "\"\": blank"

		p6_test_run "p6_string_blank" ''
		p6_test_assert_run_ok "'': blank"

		p6_test_run "p6_string_blank" 0
		p6_test_assert_run_ok "0: not blank" 1

		p6_test_run "p6_string_blank" 1
		p6_test_assert_run_ok "1: not blank" 1

		p6_test_run "p6_string_blank" -
		p6_test_assert_run_ok "-: not blank" 1

		p6_test_run "p6_string_blank" -1
		p6_test_assert_run_ok "-1: not blank" 1

		p6_test_run "p6_string_blank" "' '"
		p6_test_assert_run_ok "' ': not blank" 1

		p6_test_run "p6_string_blank" "a"
		p6_test_assert_run_ok "a: not blank" 1

		p6_test_run "p6_string_blank" "abcdef"
		p6_test_assert_run_ok "abcdef: not blank" 1

		p6_test_run "p6_string_blank" "a b"
		p6_test_assert_run_ok "a b: not blank" 1
	)
	p6_test_finish

	p6_test_teardown
}

main "$@"
