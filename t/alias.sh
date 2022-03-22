# shellcheck shell=bash

main() {

	. ../p6common/lib/_bootstrap.sh
	p6_bootstrap "../p6common"

	p6_test_setup "9"

	p6_test_start "p6_alias"
	(
		p6_test_run "p6_alias"
		p6_test_assert_run_ok "no arg"

		p6_test_run "p6_alias" "A"
		p6_test_assert_run_ok "one arg"

		p6_test_run "p6_alias" "C" "'echo 777'"
		p6_test_assert_run_ok "two args"

		#		p6_test_run "alias B='echo 777'; B"
		#		p6_test_assert_eq "$(p6_test_run_stdout)" "777" "alias works"
		#		p6_test_assert_blank "$(p6_test_run_stderr)" "no stderr"

		#		p6_test_run "p6_alias" "B"
		#		p6_test_todo "$(p6_test_run_stdout)" "'echo 777'" "find alias" "not impl"
	)
	p6_test_finish

	p6_test_teardown
}

main "$@"
