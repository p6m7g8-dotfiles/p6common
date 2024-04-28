# shellcheck shell=bash

######################################################################
#<
#
# Function: filter  = p6_filter_sort()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_sort() {

    sort

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_sort_reverse()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_sort_reverse() {

    sort -r

    p6_return_filter
}
