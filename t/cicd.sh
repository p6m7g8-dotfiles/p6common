# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "8"

    p6_test_start "p6_cicd__debug"
    (
        p6_test_run "p6_cicd__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_cicd_tests_run"
    (
        p6_test_skip "requires build/test tooling" "p6_cicd_tests_run"
    )
    p6_test_finish

    p6_test_start "p6_cicd_test_benchmark"
    (
        p6_test_skip "requires build/test tooling" "p6_cicd_test_benchmark"
    )
    p6_test_finish

    p6_test_start "p6_cicd_release_make"
    (
        p6_test_skip "requires release tooling" "p6_cicd_release_make"
    )
    p6_test_finish

    p6_test_start "p6_cicd_build_run"
    (
        p6_test_skip "requires build tooling" "p6_cicd_build_run"
    )
    p6_test_finish

    p6_test_start "p6_cicd_doc_gen"
    (
        p6_test_skip "requires doc tooling" "p6_cicd_doc_gen"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
