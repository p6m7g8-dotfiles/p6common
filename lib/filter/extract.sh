# shellcheck shell=bash

######################################################################
#<
#
# Function: filter  = p6_filter_extract_after(pattern)
#
#  Args:
#	pattern - delimiter pattern
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Strip everything through the pattern, leaving content after it.
######################################################################
p6_filter_extract_after() {
    local pattern="$1" # delimiter pattern

    sed -e "s,.*${pattern},,"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_extract_before(pattern)
#
#  Args:
#	pattern - delimiter pattern
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Strip everything after the pattern, leaving content before it.
######################################################################
p6_filter_extract_before() {
    local pattern="$1" # delimiter pattern

    sed -e "s,${pattern}.*,,"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_extract_between(start, end)
#
#  Args:
#	start - start pattern
#	end - end pattern
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Extract content between start and end patterns.
######################################################################
p6_filter_extract_between() {
    local start="$1" # start pattern
    local end="$2"   # end pattern

    sed -e "s,.*${start},," -e "s,${end}.*,,"

    p6_return_filter
}
