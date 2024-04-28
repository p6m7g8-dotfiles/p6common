# shellcheck shell=bash

######################################################################
#<
#
# Function: filter  = p6_filter_sql_escape_single_quote()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_sql_escape_single_quote() {

	sed -e "s/'/''/g"

	p6_return_filter
}
