# shellcheck shell=bash

p6_trace_on() {

    set -x

    p6_return_void
}

p6_trace_off() {

    set +x

    p6_return_void
}
