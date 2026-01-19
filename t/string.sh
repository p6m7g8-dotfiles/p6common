# shellcheck shell=bash

main() {

	. ../p6common/lib/_bootstrap.sh
	p6_bootstrap "../p6common"

	p6_test_setup "66"

	p6_test_start "p6_string__debug"
	(
		p6_test_run "p6_string__debug ping"
		p6_test_assert_run_ok "debug"
	)
	p6_test_finish

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

	p6_test_start "p6_string_eq"
	(
		p6_test_run "p6_string_eq foo foo"
		p6_test_assert_run_ok "eq"
	)
	p6_test_finish

	p6_test_start "p6_string_eq_1"
	(
		p6_test_run "p6_string_eq_1 1"
		p6_test_assert_run_ok "eq_1"
	)
	p6_test_finish

	p6_test_start "p6_string_len"
	(
		p6_test_run "p6_string_len abc"
		p6_test_assert_run_ok "len" 0 "3"
	)
	p6_test_finish

	p6_test_start "p6_string_append"
	(
		p6_test_run "p6_string_append a b :"
		p6_test_assert_run_ok "append" 0 "a:b"
	)
	p6_test_finish

	p6_test_start "p6_string_prepend"
	(
		p6_test_run "p6_string_prepend b a :"
		p6_test_assert_run_ok "prepend" 0 "a:b"
	)
	p6_test_finish

	p6_test_start "p6_string_lc"
	(
		p6_test_run "p6_string_lc AbC"
		p6_test_assert_run_ok "lc" 0 "abc"
	)
	p6_test_finish

	p6_test_start "p6_string_uc"
	(
		p6_test_run "p6_string_uc aBc"
		p6_test_assert_run_ok "uc" 0 "ABC"
	)
	p6_test_finish

	p6_test_start "p6_string_replace"
	(
		p6_test_run "p6_string_replace aab a x"
		p6_test_assert_run_ok "replace" 0 "xxb"
	)
	p6_test_finish

	p6_test_start "p6_string_init_cap"
	(
		p6_test_run "p6_string_init_cap 'hello world'"
		p6_test_assert_run_ok "init_cap" 0 "Hello World"
	)
	p6_test_finish

	p6_test_start "p6_string_zero_pad"
	(
		p6_test_run "p6_string_zero_pad 7 3"
		p6_test_assert_run_ok "zero_pad" 0 "007"
	)
	p6_test_finish

	p6_test_teardown
}

main "$@"
