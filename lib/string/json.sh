# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_json__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for JSON helpers.
######################################################################
p6_json__debug() {
    local msg="$1" # debug message

    p6_debug "p6_json: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_json_eval(json, ...)
#
#  Args:
#	json - JSON input
#	... - jq filter and options
#
#>
#/ Synopsis
#/    Run jq against a JSON string.
######################################################################
p6_json_eval() {
    local json="$1" # JSON input
    shift 1         # jq filter and options

    p6_echo "$json" | jq "$@"
}

######################################################################
#<
#
# Function: p6_json_from_file(file)
#
#  Args:
#	file - JSON file path
#
#>
#/ Synopsis
#/    Output JSON content from a file.
######################################################################
p6_json_from_file() {
    local file="$1" # JSON file path

    jq <"$file"

    p6_return_void
}
