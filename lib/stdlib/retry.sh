# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_retry__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for retry helpers.
######################################################################
p6_retry__debug() {
    local msg="$1" # debug message

    p6_debug "p6_retry: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_retry_delay_doubling()
#
#>
#/ Synopsis
#/    Sleep and double the retry delay.
######################################################################
p6_retry_delay_doubling() {

    p6_retry_delay "double" "$@"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_retry_delay_log()
#
#>
#/ Synopsis
#/    Sleep and compute the next delay using log strategy.
######################################################################
p6_retry_delay_log() {

    p6_retry_delay "log" "$@"

    p6_return_void
}

######################################################################
#<
#
# Function: size_t i = p6_retry_delay(type, i)
#
#  Args:
#	type - delay strategy
#	i - current delay
#
#  Returns:
#	size_t - i
#
#  Environment:	 P6_EXIT_FATAL
#>
#/ Synopsis
#/    Sleep for a delay and compute the next delay value.
######################################################################
p6_retry_delay() {
    local type="$1" # delay strategy
    local i="$2"    # current delay

    sleep "$i"

    case $type in
    double) i=$(($i * 2)) ;;
        #	log) ;;
    esac

    if [ $i -gt 300 ]; then
        p6_die "$P6_EXIT_FATAL" "FATAL"
    fi

    p6_return_size_t "$i"
}
