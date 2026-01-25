# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_date__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emits a debug message scoped to date helpers.
######################################################################
p6_date__debug() {
    local msg="$1" # debug message

    p6_debug "p6_date: $msg"

    p6_return_void
}
