# shellcheck shell=bash

main() {

	. ../p6common/lib/_bootstrap.sh
	p6_bootstrap "../p6common"

	p6_test_setup "71"

	p6_test_start "p6_debugging"
	(
		p6_test_run "p6_debugging"
		p6_test_assert_run_ok "default" 1

		#		p6_test_skip "environment variable issue"

		p6_test_assert_run_ok "undef P6_DEBUG"

		P6_DEBUG=0 p6_test_run "p6_debugging"
		p6_test_assert_run_ok "p6_d=0"

		P6_DEBUG=1 p6_test_run "p6_debugging"
		p6_test_assert_run_ok "p6_d=1"

		P6_DEBUG=word p6_test_run "p6_debugging"
		p6_test_assert_run_ok "p6_d=word"

		P6_DEBUG="word1 word2" p6_test_run "p6_debugging"
		p6_test_assert_run_ok "p6_d=word1 word2"
	)
	p6_test_finish

	p6_test_start "p6_verbose"
	(
		p6_test_run "p6_verbose"
		p6_test_assert_run_ok "no args"

		p6_test_run "p6_verbose a"
		p6_test_assert_run_ok "non number"

		p6_test_run "p6_verbose -1"
		p6_test_assert_run_ok "negative number"

		p6_test_run "p6_verbose 0"
		p6_test_assert_run_ok "zero"

		p6_test_run "p6_verbose 1"
		p6_test_assert_run_ok "one"

		p6_test_run "p6_verbose 1 mymsg"
		p6_test_assert_run_ok "one one arg" "" ""

		p6_test_run "p6_verbose 1 mymsg1 mymsg2"
		p6_test_assert_run_ok "one two args" "" ""

		P6_VERBOSE=2 p6_test_run "p6_verbose 1 mymsg"
		p6_test_assert_run_ok "p6_v=2, l=1, mymsg"

		P6_VERBOSE=0 p6_test_run "p6_verbose 1 mymsg"
		p6_test_assert_run_ok "p6_v=0, l=1, mymsg"

		P6_VERBOSE=1 p6_test_run "p6_verbose 1 mymsg"
		p6_test_assert_run_ok "p6_v=1, l=1, mymsg" "" "mymsg"
	)
	p6_test_finish

	p6_test_start "p6_debug"
	(
		p6_test_run "p6_debug"
		p6_test_assert_run_ok "no args"

		p6_test_run "p6_debug mymsg"
		p6_test_assert_run_ok "mymsg"

		p6_test_run "p6_debug system:"
		p6_test_assert_run_ok "system:"

		p6_test_run "p6_debug system: mymsg"
		p6_test_assert_run_ok "system: mymsg" "0"

		p6_test_skip "waiting on p6_debugging_system_on"
		p6_test_skip "waiting on p6_test_assert_log_contains"

		p6_test_run "p6_debug system: function(): mymsg"
		p6_test_assert_run_ok "system: function() mymsg:" "1"

		P6_DEBUG=1 p6_test_run "p6_debug system: function(): mymsg"
		p6_test_assert_run_ok "1, system: function() mymsg:" "1"

		P6_DEBUG=all p6_test_run "p6_debug system: function(): mymsg"
		p6_test_assert_run_ok "all, system: function() mymsg:" "1"

		P6_DEBUG=foo p6_test_run "p6_debug system: function(): mymsg"
		p6_test_assert_run_ok "foo, system: function() mymsg:" "1"

		P6_DEBUG=system p6_test_run "p6_debug system: function(): mymsg"
		p6_test_assert_run_ok "system, system: function() mymsg:" "1"

		P6_DEBUG="foo bar" p6_test_run "p6_debug system: function(): mymsg"
		p6_test_assert_run_ok "foo bar, system: function() mymsg:" "1"

		P6_DEBUG="foo system bar" p6_test_run "p6_debug system: function(): mymsg"
		p6_test_assert_run_ok "foo system bar, system: function() mymsg:" "1"
	)
	p6_test_finish

	p6_test_start "p6_log"
	(
		p6_test_run "p6_log"
		p6_test_assert_run_ok "no args"

		p6_test_run "p6_log mymsg"
		p6_test_assert_run_ok "mymsg"
		p6_test_skip "waiting on p6_test_assert_log_contains"
		p6_test_assert_log_contains "mymsg"
	)
	p6_test_finish

	p6_test_start "p6_debugging_system_on"
	(
		true
	)
	p6_test_finish

	p6_test_start "p6_dryrunning"
	(
		p6_test_run "p6_dryrunning"
		p6_test_assert_run_ok "default" "1"

		p6_test_skip "environment variable issue"

		p6_test_assert_run_ok "undef P6_DEBUG"

		P6_DRY_RUN=0 p6_test_run "p6_dryrunning"
		p6_test_assert_run_ok "p6_dr=0"

		P6_DRY_RUN=1 p6_test_run "p6_dryrunning"
		p6_test_assert_run_ok "p6_dr=1"

		P6_DRY_RUN=word p6_test_run "p6_dryrunning"
		p6_test_assert_run_ok "p6_dr=word"

		P6_DRY_RUN="word1 word2" p6_test_run "p6_dryrunning"
		p6_test_assert_run_ok "p6_dr=word1 word2"
	)
	p6_test_finish

	p6_test_teardown
}

main "$@"
