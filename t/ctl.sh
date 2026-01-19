# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "7"

    p6_test_start "p6_ctl_usage"
    (
        p6_test_skip "exits the process" "p6_ctl_usage"
    )
    p6_test_finish

    p6_test_start "p6_ctl_run"
    (
        p6_test_skip "invokes external tooling" "p6_ctl_run"
    )
    p6_test_finish

    p6_test_start "p6_ctl_cmd_docker_build"
    (
        p6_test_skip "requires docker/apk" "p6_ctl_cmd_docker_build"
    )
    p6_test_finish

    p6_test_start "p6_ctl_cmd_install"
    (
        p6_test_skip "requires installer tooling" "p6_ctl_cmd_install"
    )
    p6_test_finish

    p6_test_start "p6_ctl_cmd_docker_test"
    (
        p6_test_skip "requires docker" "p6_ctl_cmd_docker_test"
    )
    p6_test_finish

    p6_test_start "p6_ctl_cmd_test"
    (
        p6_test_skip "runs full test suite" "p6_ctl_cmd_test"
    )
    p6_test_finish

    p6_test_start "p6_ctl_cmd_build"
    (
        p6_test_skip "runs build pipeline" "p6_ctl_cmd_build"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
