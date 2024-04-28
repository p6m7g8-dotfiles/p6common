# shellcheck shell=bash

######################################################################
#<
#
# Function: filter  = p6_filter_row_select()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_row_select() {
    shift 0

    grep "$@"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_select_and_after(selector, count)
#
#  Args:
#	selector -
#	count -
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_row_select_and_after() {
    local selector="$1"
    local count="$2"

    grep -A $count "$selector"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_exclude(selector)
#
#  Args:
#	selector -
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_row_exclude() {
    local selector="$1"

    grep -v "$selector"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_first(n)
#
#  Args:
#	n -
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_row_first() {
    local n="$1"

    head -n $n

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_last(n)
#
#  Args:
#	n -
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_row_last() {
    local n="$1"

    tail -n $n

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_from_end(n)
#
#  Args:
#	n -
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_row_from_end() {
    local n="$1"

    tail -n "$n" | head -n "1"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_n(n)
#
#  Args:
#	n -
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_row_n() {
    local n="$1"

    sed -n "${n}p"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_rows_count()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_rows_count() {

    wc -l

    p6_return_filter
}
