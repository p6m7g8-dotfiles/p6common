# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_yml__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emits a debug message scoped to the yml helper.
######################################################################
p6_yml__debug() {
    local msg="$1" # debug message

    p6_debug "p6_yml: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_yml_eval(yml, ...)
#
#  Args:
#	yml - YAML content
#	... - yq options and query
#
#>
#/ Synopsis
#/    Evaluates a yq query against a YAML string.
######################################################################
p6_yml_eval() {
    local yml="$1" # YAML content
    shift 1        # yq options and query

    p6_echo "$yml" | yq "$@"
}

######################################################################
#<
#
# Function: stream  = p6_yml_from_file(file, query)
#
#  Args:
#	file - YAML file path
#	query - yq query string (optional)
#
#  Returns:
#	stream - 
#
#>
#/ Synopsis
#/    Reads YAML from file and optionally applies a yq query.
######################################################################
p6_yml_from_file() {
    local file="$1"  # YAML file path
    local query="$2" # yq query string (optional)

    if p6_string_blank "$query"; then
        yq <"$file"
    else
        yq -r "$query" <"$file"
    fi

    p6_return_stream
}

######################################################################
#<
#
# Function: p6_yml_update_in_file(file, query)
#
#  Args:
#	file - YAML file path
#	query - yq query
#
#>
######################################################################
p6_yml_update_in_file() {
    local file="$1"  # YAML file path
    local query="$2" # yq query

    yq -i "$query" "$file"

    p6_return_void
}
