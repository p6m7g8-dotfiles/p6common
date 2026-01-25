# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_openssl__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emits a debug message scoped to OpenSSL helpers.
######################################################################
p6_openssl__debug() {
    local msg="$1" # debug message

    p6_debug "p6_openssl: $msg"

    p6_return_void
}
