# shellcheck shell=bash

main() {

	. ../p6common/lib/_bootstrap.sh
	p6_bootstrap "../p6common"

	p6_test_setup "183"

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

	p6_test_start "p6_string_blank_NOT"
	(
		p6_test_run "p6_string_blank_NOT" "a"
		p6_test_assert_run_ok "blank_NOT: a"

		p6_test_run "p6_string_blank_NOT" ""
		p6_test_assert_run_ok "blank_NOT: blank" 1
	)
	p6_test_finish

	p6_test_start "p6_string_eq"
	(
		p6_test_run "p6_string_eq foo foo"
		p6_test_assert_run_ok "eq"
	)
	p6_test_finish

	p6_test_start "p6_string_ne"
	(
		p6_test_run "p6_string_ne" "foo" "bar"
		p6_test_assert_run_ok "ne"

		p6_test_run "p6_string_ne" "foo" "foo"
		p6_test_assert_run_ok "ne: eq" 1
	)
	p6_test_finish

	p6_test_start "p6_string_eq_1"
	(
		p6_test_run "p6_string_eq_1 1"
		p6_test_assert_run_ok "eq_1"
	)
	p6_test_finish

	p6_test_start "p6_string_eq_0"
	(
		p6_test_run "p6_string_eq_0 0"
		p6_test_assert_run_ok "eq_0"
	)
	p6_test_finish

	p6_test_start "p6_string_eq_neg_1"
	(
		p6_test_run "p6_string_eq_neg_1 -1"
		p6_test_assert_run_ok "eq_neg_1"
	)
	p6_test_finish

	p6_test_start "p6_string_eq_any"
	(
		p6_test_run "p6_string_eq_any" "b" "a" "b" "c"
		p6_test_assert_run_ok "eq_any"

		p6_test_run "p6_string_eq_any" "z" "a" "b" "c"
		p6_test_assert_run_ok "eq_any: none" 1
	)
	p6_test_finish

	p6_test_start "p6_string_contains"
	(
		p6_test_run "p6_string_contains" "abc" "b"
		p6_test_assert_run_ok "contains"

		p6_test_run "p6_string_contains" "abc" "d"
		p6_test_assert_run_ok "contains: no" 1
	)
	p6_test_finish

	p6_test_start "p6_string_starts_with"
	(
		p6_test_run "p6_string_starts_with" "abcdef" "abc"
		p6_test_assert_run_ok "starts_with"

		p6_test_run "p6_string_starts_with" "abcdef" "bcd"
		p6_test_assert_run_ok "starts_with: no" 1
	)
	p6_test_finish

	p6_test_start "p6_string_ends_with"
	(
		p6_test_run "p6_string_ends_with" "abcdef" "def"
		p6_test_assert_run_ok "ends_with"

		p6_test_run "p6_string_ends_with" "abcdef" "de"
		p6_test_assert_run_ok "ends_with: no" 1
	)
	p6_test_finish

	p6_test_start "p6_string_match_regex"
	(
		p6_test_run "p6_string_match_regex" "abc123" "'^[a-z]+[0-9]+$'"
		p6_test_assert_run_ok "match_regex"

		p6_test_run "p6_string_match_regex" "abc123" "'^[0-9]+$'"
		p6_test_assert_run_ok "match_regex: no" 1
	)
	p6_test_finish

	p6_test_start "p6_string_len"
	(
		p6_test_run "p6_string_len abc"
		p6_test_assert_run_ok "len" 0 "3"
	)
	p6_test_finish

	p6_test_start "p6_string_default"
	(
		p6_test_run "p6_string_default" "" "fallback"
		p6_test_assert_run_ok "default: blank" 0 "fallback"

		p6_test_run "p6_string_default" "value" "fallback"
		p6_test_assert_run_ok "default: value" 0 "value"
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
		p6_test_run "p6_string_replace a-b-c - _"
		p6_test_assert_run_ok "replace" 0 "a_b_c"
	)
	p6_test_finish

	p6_test_start "p6_string_strip_prefix"
	(
		p6_test_run "p6_string_strip_prefix aws_region aws_"
		p6_test_assert_run_ok "strip_prefix" 0 "region"
	)
	p6_test_finish

	p6_test_start "p6_string_strip_suffix"
	(
		p6_test_run "p6_string_strip_suffix foo_active _active"
		p6_test_assert_run_ok "strip_suffix" 0 "foo"
	)
	p6_test_finish

	p6_test_start "p6_string_strip_single_quote"
	(
		p6_test_run "p6_string_strip_single_quote \"a'b\""
		p6_test_assert_run_ok "single_quote_strip" 0 "ab"
	)
	p6_test_finish

	p6_test_start "p6_string_strip_double_quote"
	(
		p6_test_run "p6_string_strip_double_quote 'a\"b'"
		p6_test_assert_run_ok "double_quote_strip" 0 "ab"
	)
	p6_test_finish

	p6_test_start "p6_string_strip_quotes"
	(
		p6_test_run "p6_string_strip_quotes \"a'b\""
		p6_test_assert_run_ok "quotes_strip: single" 0 "ab"

		p6_test_run "p6_string_strip_quotes 'a\"b'"
		p6_test_assert_run_ok "quotes_strip: double" 0 "ab"
	)
	p6_test_finish

	p6_test_start "p6_string_strip_chars"
	(
		p6_test_run "p6_string_strip_chars a-b_c -_"
		p6_test_assert_run_ok "chars_strip" 0 "abc"
	)
	p6_test_finish

	p6_test_start "p6_string_strip_leading_spaces"
	(
		p6_test_run "p6_string_strip_leading_spaces '  foo'"
		p6_test_assert_run_ok "leading_spaces_strip" 0 "foo"
	)
	p6_test_finish

	p6_test_start "p6_string_strip_trailing_spaces"
	(
		p6_test_run "p6_string_strip_trailing_spaces 'foo  '"
		p6_test_assert_run_ok "trailing_spaces_strip" 0 "foo"
	)
	p6_test_finish

	p6_test_start "p6_string_strip_leading_and_trailing_spaces"
	(
		p6_test_run "p6_string_strip_leading_and_trailing_spaces '  foo  '"
		p6_test_assert_run_ok "leading_and_trailing_spaces_strip" 0 "foo"
	)
	p6_test_finish

	p6_test_start "p6_string_strip_spaces"
	(
		p6_test_run "p6_string_strip_spaces 'a b  c'"
		p6_test_assert_run_ok "spaces_strip" 0 "abc"
	)
	p6_test_finish

	p6_test_start "p6_string_strip_alum"
	(
		p6_test_run "p6_string_strip_alum a1-_"
		p6_test_assert_run_ok "alnum_strip" 0 "-_"
	)
	p6_test_finish

	p6_test_start "p6_string_strip_alum_and_underscore"
	(
		p6_test_run "p6_string_strip_alum_and_underscore a1_+"
		p6_test_assert_run_ok "alnum_and_underscore_strip" 0 "+"
	)
	p6_test_finish

	p6_test_start "p6_string_strip_trailing_slash"
	(
		p6_test_run "p6_string_strip_trailing_slash foo/"
		p6_test_assert_run_ok "trailing_slash_strip" 0 "foo"
	)
	p6_test_finish

	p6_test_start "p6_string_nodeenv_to_nodenv"
	(
		p6_test_run "p6_string_nodeenv_to_nodenv nodeenv"
		p6_test_assert_run_ok "nodeenv_to_nodenv" 0 "nodenv"
	)
	p6_test_finish

	p6_test_start "p6_string_sanitize_dot_id"
	(
		p6_test_run "p6_string_sanitize_dot_id 'foo:bar/baz-1.0'"
		p6_test_assert_run_ok "sanitize_dot_id" 0 "foo_bar_baz_1_0"
	)
	p6_test_finish

	p6_test_start "p6_string_sanitize_identifier"
	(
		p6_test_run "p6_string_sanitize_identifier 'mod-name'"
		p6_test_assert_run_ok "sanitize_identifier" 0 "mod_name"
	)
	p6_test_finish

	p6_test_start "p6_string_strip_non_branch_chars"
	(
		p6_test_run "p6_string_strip_non_branch_chars 'a!b#'"
		p6_test_assert_run_ok "strip_non_branch_chars" 0 "ab#"
	)
	p6_test_finish

	p6_test_start "p6_string_strip_brackets"
	(
		p6_test_run "p6_string_strip_brackets '[profile foo]'"
		p6_test_assert_run_ok "brackets_strip" 0 "profile foo"
	)
	p6_test_finish

	p6_test_start "p6_string_slash_to_underscore"
	(
		p6_test_run "p6_string_slash_to_underscore 'a/b'"
		p6_test_assert_run_ok "slash_to_underscore" 0 "a_b"
	)
	p6_test_finish

	p6_test_start "p6_string_collapse_double_slash"
	(
		p6_test_run "p6_string_collapse_double_slash 'a//b'"
		p6_test_assert_run_ok "collapse_double_slash" 0 "a/b"
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
