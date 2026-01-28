# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_filter__string_apply(func, ...)
#
#  Args:
#	func - function to apply per line
#	... - additional arguments for func
#
#>
#/ Synopsis
#/    Apply a string function to each input line.
######################################################################
p6_filter__string_apply() {
    local func="$1" # function to apply per line
    shift 1         # additional arguments for func

    local line
    local rc=0
    while IFS= read -r line || p6_string_blank_NOT "$line"; do
        "$func" "$line" "$@"
        rc=$?
    done

    return "$rc"
}

######################################################################
#<
#
# Function: filter  = p6_filter_string_first_character()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Emit the first character of each input line.
######################################################################
p6_filter_string_first_character() {

    cut -c 1

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_lowercase()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Lowercase each input line.
######################################################################
p6_filter_lowercase() {

    p6_filter__string_apply p6_string_lc

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_uppercase()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Uppercase each input line.
######################################################################
p6_filter_uppercase() {

    p6_filter__string_apply p6_string_uc

    p6_return_filter
}
