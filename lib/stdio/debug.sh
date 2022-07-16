# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_debug__debug()
#
#>
######################################################################
p6_debug__debug() {
    local msg="$1" # msg to log

    p6_debug "p6_debug: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_time(t0, t1, msg)
#
#  Args:
#	t0 -
#	t1 -
#	msg -
#
#>
######################################################################
p6_time() {
    local t0="$1"
    local t1="$2"
    local msg="$3"

    local delta
    if [ -n "$t0" ] && [ -n "$t1" ]; then
        delta=$(($t1 - $t0))
        delta=$(printf "%.3f" "$delta")
        p6_echo "p6_time: $delta $msg" >>/tmp/p6/time.log
    fi
}

######################################################################
#<
#
# Function: p6_verbose(level)
#
#  Args:
#	level - minimum verbosity before output
#
#  Environment:	 P6_VERBOSE
#>
######################################################################
p6_verbose() {
    local level="$1" # minimum verbosity before output
    shift

    if [ -n "$level" ]; then
        P6_VERBOSE=${P6_VERBOSE:-0}

        case $level in
        [0-9]*)
            if [ $P6_VERBOSE -ne 0 ] && [ \( $level -gt $P6_VERBOSE -o $level -eq $P6_VERBOSE \) ]; then
                p6_msg "$@"
            fi
            ;;
        esac
    fi

    p6_return_void
}

######################################################################
#<
#
# Function: p6_debug(msg)
#
#  Args:
#	msg -
#
#  Environment:	 P6_DEBUG P6_PREFIX
#>
######################################################################
p6_debug() {
    local msg="$1"

    local systems="$P6_DEBUG"
    local system=$(p6_echo "$msg" | cut -d : -f 1)

    if p6_debugging; then
        if p6_debugging_system_on "$systems" "$system"; then
            p6_msg "$msg" >>$P6_PREFIX/tmp/p6/debug.log
        fi
    fi

    p6_return_void
}

######################################################################
#<
#
# Function: p6_log(msg)
#
#  Args:
#	msg -
#
#  Environment:	 P6_DFZ_LOG_DISABLED
#>
######################################################################
p6_log() {
    local msg="$*"

    if [ -z "$P6_DFZ_LOG_DISABLED" ]; then
        p6_msg "$msg" >>/tmp/p6/log.log
    fi

    p6_return_void
}

######################################################################
#<
#
# Function: p6_log_disable()
#
#  Environment:	 P6_DFZ_LOG_DISABLED
#>
######################################################################
p6_log_disable() {

    export P6_DFZ_LOG_DISABLED=1
}

######################################################################
#<
#
# Function: p6_log_enable()
#
#  Environment:	 P6_DFZ_LOG_DISABLED
#>
######################################################################
p6_log_enable() {

    unset P6_DFZ_LOG_DISABLED
}

######################################################################
#<
#
# Function: bool rv = p6_debugging()
#
#  Returns:
#	bool - rv
#
#  Environment:	 P6_DEBUG
#>
######################################################################
p6_debugging() {

    test -n "${P6_DEBUG}"
    local rv=$?

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: code rc = p6_debugging_system_on(systems, system)
#
#  Args:
#	systems -
#	system -
#
#  Returns:
#	code - rc
#
#  Environment:	 P6_FALSE P6_TRUE
#>
######################################################################
p6_debugging_system_on() {
    local systems="$1"
    local system="$2"

    local rc=$P6_FALSE

    case $systems in
    *$system*) rc=$P6_TRUE ;;
    esac

    case $systems in
    *all*) rc=$P6_TRUE ;;
    esac

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: bool rv = p6_dryrunning()
#
#  Returns:
#	bool - rv
#
#  Environment:	 P6_DRY_RUN
#>
######################################################################
p6_dryrunning() {

    test -n "${P6_DRY_RUN}"
    local rv=$?

    p6_return_bool "$rv"
}
