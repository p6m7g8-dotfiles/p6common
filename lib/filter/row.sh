# shellcheck shell=bash

######################################################################
#<
#
# Function: filter  = p6_filter_row_select(...)
#
#  Args:
#	... - grep options and pattern
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Select rows matching the given grep arguments.
######################################################################
p6_filter_row_select() {
    shift 0 # grep options and pattern

    grep "$@"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_select_regex(selector)
#
#  Args:
#	selector - extended regex pattern
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Select rows matching an extended regex.
######################################################################
p6_filter_row_select_regex() {
    local selector="$1" # extended regex pattern

    grep -E "$selector"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_select_icase(selector)
#
#  Args:
#	selector - pattern
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Select rows matching a pattern, case-insensitive.
######################################################################
p6_filter_row_select_icase() {
    local selector="$1" # pattern

    grep -i "$selector"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_select_and_after(selector, count)
#
#  Args:
#	selector - pattern
#	count - number of following rows
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Select matching rows and the following N rows.
######################################################################
p6_filter_row_select_and_after() {
    local selector="$1" # pattern
    local count="$2"    # number of following rows

    grep -A $count "$selector"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_exclude(selector)
#
#  Args:
#	selector - pattern
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Exclude rows matching a pattern.
######################################################################
p6_filter_row_exclude() {
    local selector="$1" # pattern

    grep -v "$selector"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_exclude_regex(selector)
#
#  Args:
#	selector - extended regex pattern
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Exclude rows matching an extended regex.
######################################################################
p6_filter_row_exclude_regex() {
    local selector="$1" # extended regex pattern

    grep -Ev "$selector" || true

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_exclude_icase(selector)
#
#  Args:
#	selector - pattern
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Exclude rows matching a pattern, case-insensitive.
######################################################################
p6_filter_row_exclude_icase() {
    local selector="$1" # pattern

    grep -iv "$selector" || true

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_first(n)
#
#  Args:
#	n - number of rows
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Keep only the first N rows.
######################################################################
p6_filter_row_first() {
    local n="$1" # number of rows

    head -n $n

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_last(n)
#
#  Args:
#	n - number of rows
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Keep only the last N rows.
######################################################################
p6_filter_row_last() {
    local n="$1" # number of rows

    tail -n $n

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_from_end(n)
#
#  Args:
#	n - index from end
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Emit the Nth row from the end.
######################################################################
p6_filter_row_from_end() {
    local n="$1" # index from end

    tail -n "$n" | head -n "1"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_row_n(n)
#
#  Args:
#	n - row number
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Emit the Nth row from the start.
######################################################################
p6_filter_row_n() {
    local n="$1" # row number

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
#/ Synopsis
#/    Count the number of rows.
######################################################################
p6_filter_rows_count() {

    wc -l

    p6_return_filter
}
