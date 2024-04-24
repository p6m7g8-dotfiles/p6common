# shellcheck shell=bash

main() {

	. ../p6common/lib/_bootstrap.sh
	p6_bootstrap "../p6common"

	p6_test_setup "81"

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
		p6_test_assert_run_ok "two arg f,b is 0, no stderr" "0" "0"
	)
	p6_test_finish

	p6_test_start "p6_color_say"
	(
		p6_test_skip "newline issue" "lazy" "$P6_TRUE"
		local msg="mymsg
"
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
			local color=$(echo $pair | cut -d : -f 1)
			local code=$(echo $pair | cut -d : -f 2)

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
			local color=$(echo $pair | cut -d : -f 1)
			local rgb=$(echo $pair | cut -d : -f 2)

			p6_test_run "p6_color_name_to_rgb $color"
			p6_test_assert_run_ok "$color is $rgb" "" "$rgb"
		done
	)
	p6_test_finish

	p6_test_teardown
}

main "$@"
