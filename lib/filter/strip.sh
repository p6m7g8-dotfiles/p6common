# shellcheck shell=bash

######################################################################
#<
#
# Function: filter  = p6_filter_single_quote_strip()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_single_quote_strip() {

    sed -e "s,',,g"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_double_quote_strip()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_double_quote_strip() {

    sed -e 's,",,g'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_quotes_strip()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_quotes_strip() {

    sed -e "s,[\"\'],,g"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_leading_spaces_strip()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_leading_spaces_strip() {

    sed -e 's,^ *,,g'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_trailing_spaces_strip()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_trailing_spaces_strip() {

    sed -e 's, *$,,g'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_leading_and_trailing_spaces_strip()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_leading_and_trailing_spaces_strip() {

    p6_filter_trailing_spaces_strip | p6_filter_leading_spaces_strip

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_spaces_strip()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_spaces_strip() {

    sed -e 's, *,,g'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_alnum_strip()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_alnum_strip() {

    sed -e 's,[a-zA-Z0-9],,g'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_alnum_and_underscore_strip()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_alnum_and_underscore_strip() {

    sed -e 's,[a-zA-Z0-9_],,g'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_trailing_slash_strip()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_trailing_slash_strip() {

    sed -e 's,/$,,'

    p6_return_filter
}
