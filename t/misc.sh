# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "6"

    p6_test_start "p6_pgs"
    (
        p6_test_run "mkdir work; echo foo > work/file.txt; (cd work && p6_pgs foo bar); cat work/file.txt"
        p6_test_assert_run_ok "pgs" 0 "bar"
    )
    p6_test_finish

    p6_test_start "p6_xclean"
    (
        p6_test_run "mkdir work; touch work/.DS_Store work/file~; (cd work && p6_xclean > /dev/null); find work -type f"
        p6_test_assert_run_ok "xclean"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
