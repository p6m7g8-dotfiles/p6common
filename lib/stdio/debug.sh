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
# Function: p6_debug()
#
#>
######################################################################
p6_debug() {
    local msg="$1"

    if p6_debugging; then
        local systems="$P6_DEBUG"
        local system=$(p6_echo "$msg" | cut -d : -f 1)

        if p6_debugging_system_on "$systems" "$system"; then
            p6_echo "$msg" >>$P6_PREFIX/tmp/p6/debug.log
        fi
    fi

    p6_return_void
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
