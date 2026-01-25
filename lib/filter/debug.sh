# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_filter__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for filter helpers.
######################################################################
p6_filter__debug() {
    local msg="$1" # debug message

    p6_debug "p6_filter: $msg"

    p6_return_void
}
