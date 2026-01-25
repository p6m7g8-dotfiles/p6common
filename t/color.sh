# shellcheck shell=bash

main() {

	. ../p6common/lib/_bootstrap.sh
	p6_bootstrap "../p6common"

	p6_test_setup "94"

	p6_test_start "p6_color__debug"
	(
		p6_test_run "p6_color__debug ping"
		p6_test_assert_run_ok "debug"
	)
	p6_test_finish

	p6_test_start "p6_color_ize"
	(
		P6_TEST_COLOR_OFF=1
		p6_test_run "P6_TEST_COLOR_OFF=1 p6_color_ize red blue hello"
		p6_test_assert_run_rc "color_ize: rc" 0
		p6_test_assert_not_blank "$(p6_test_run_stdout)" "color_ize: stdout"
		p6_test_assert_blank "$(p6_test_run_stderr)" "color_ize: stderr blank"
	)
	p6_test_finish

	p6_test_start "p6_color_opacity_factor"
	(
		p6_test_run "p6_color_opacity_factor"
		p6_test_assert_run_ok "returns only 0.0" "" "0.0"
	)
	p6_test_finish

	p6_test_start "p6_color_hex_to_d16b"
	(
		p6_test_run "p6_color_hex_to_d16b FFFFFF r"
		p6_test_assert_run_ok "two arg F,r is 65535, no stderr" "0" "65535"

		p6_test_run "p6_color_hex_to_d16b FFFFFF g"
		p6_test_assert_run_ok "two arg F,g is 65535, no stderr" "0" "65535"

		p6_test_run "p6_color_hex_to_d16b FFFFFF b"
		p6_test_assert_run_ok "two arg F,b is 65535, no stderr" "0" "65535"

		# lower case does not convert intentionally
		p6_test_run "p6_color_hex_to_d16b ffffff b"
		p6_test_assert_run_ok "two arg f,b is 0, no stderr" "0" "65535"
	)
	p6_test_finish

	p6_test_start "p6_color_hext_to_rgb"
	(
		p6_test_run "p6_color_hext_to_rgb FF"
		p6_test_assert_run_ok "hext_to_rgb" 0 "255"
	)
	p6_test_finish

	p6_test_start "p6_color_say"
	(
		p6_test_skip "newline issue" "lazy" "$P6_TRUE"
		local msg="mymsg"
		P6_TEST_COLOR_OFF=1
		p6_test_run "p6_color_say red blue mymsg"
		p6_test_assert_run_ok "red blue mymsg, no stderr" "" "$msg"

	)
	p6_test_finish

	p6_test_start "p6_color_to_code"
	(
		local pairs="black:0 red:1 green:2 yellow:3 blue:4 magenta:5 cyan:6 white:7"
		local pair
		for pair in $pairs; do
			local color=$(p6_echo "$pair" | p6_filter_column_pluck 1 ":")
			local code=$(p6_echo "$pair" | p6_filter_column_pluck 2 ":")

			p6_test_run "p6_color_to_code $color"
			p6_test_assert_run_ok "$color has code $code" "" "$code"
		done
	)
	p6_test_finish

	p6_test_start "p6_color_name_to_rgb"
	(
		local pairs="red:FA053E \
		     orange:FA6B05 \
		     yellow:DEDB86 \
		     green:1C6928 \
		     cyan:3BEAF6 \
		     blue:054CF2 \
		     dblue:1A2261 \
		     lpurple:EB5BD5 \
		     purple:973BCC \
		     pink:F213D5 \
		     lsalmon3:CD8162 \
		     brown:542323 \
		     black:000000 \
		     white:FFFFFF"
		local pair
		for pair in $pairs; do
			local color=$(p6_echo "$pair" | p6_filter_column_pluck 1 ":")
			local rgb=$(p6_echo "$pair" | p6_filter_column_pluck 2 ":")

			p6_test_run "p6_color_name_to_rgb $color"
			p6_test_assert_run_ok "$color is $rgb" "" "$rgb"
		done
	)
	p6_test_finish

	p6_test_teardown
}

main "$@"
