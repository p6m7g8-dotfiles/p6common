# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_date__debug()
#
#>
######################################################################
p6_date__debug() {
    local msg="$1"

    p6_debug "p6_date: $msg"

    p6_return_void
}
