# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_openssl__debug(msg)
#
#  Args:
#	msg -
#
#>
######################################################################
p6_openssl__debug() {
    local msg="$1"

    p6_debug "p6_openssl: $msg"

    p6_return_void
}
