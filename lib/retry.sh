#!/bin/sh

p6_retry_delay_doubling() {

    p6_retry_delay "double" "$@"
}

p6_retry_delay_log() {

    p6_retry_delay "log" "$@"
}

p6_retry_delay() {
    local type="$1"
    local i="$2"

    p6_sleep "$i"

    case $type in
	double) i=$(($i*2)) ;;
#	log) ;;
    esac

    if [ $i -gt 300 ]; then
	p6_die "25" "FATAL"
    fi

    p6_return "$i"
}
