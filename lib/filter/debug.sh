# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_filter__debug()
#
#>
######################################################################
p6_filter__debug() {
    local msg="$1"

    p6_debug "p6_filter: $msg"

    p6_return_void
}
