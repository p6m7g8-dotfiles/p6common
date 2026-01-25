# shellcheck shell=bash

######################################################################
#<
#
# Function: filter  = p6_filter_dos2unix()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Convert CRLF line endings to LF.
######################################################################
p6_filter_dos2unix() {

    dos2unix

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_strip_single_quote()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Strip single quotes from each line.
######################################################################
p6_filter_strip_single_quote() {

    p6_filter__string_apply p6_string_strip_single_quote

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_strip_double_quote()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Strip double quotes from each line.
######################################################################
p6_filter_strip_double_quote() {

    p6_filter__string_apply p6_string_strip_double_quote

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_strip_quotes()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Strip both single and double quotes from each line.
######################################################################
p6_filter_strip_quotes() {

    p6_filter__string_apply p6_string_strip_quotes

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_strip_chars(chars)
#
#  Args:
#	chars - characters to remove
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Strip the specified characters from each line.
######################################################################
p6_filter_strip_chars() {
    local chars="$1" # characters to remove

    p6_filter__string_apply p6_string_strip_chars "$chars"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_strip_leading_spaces()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Strip leading spaces from each line.
######################################################################
p6_filter_strip_leading_spaces() {

    p6_filter__string_apply p6_string_strip_leading_spaces

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_strip_trailing_spaces()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Strip trailing spaces from each line.
######################################################################
p6_filter_strip_trailing_spaces() {

    p6_filter__string_apply p6_string_strip_trailing_spaces

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_strip_leading_and_trailing_spaces()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Strip leading and trailing spaces from each line.
######################################################################
p6_filter_strip_leading_and_trailing_spaces() {

    p6_filter__string_apply p6_string_strip_leading_and_trailing_spaces

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_strip_spaces()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Remove all spaces from each line.
######################################################################
p6_filter_strip_spaces() {

    p6_filter__string_apply p6_string_strip_spaces

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_strip_alum()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Remove alphanumeric characters from each line.
######################################################################
p6_filter_strip_alum() {

    p6_filter__string_apply p6_string_strip_alum

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_strip_alum_and_underscore()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Remove alphanumerics and underscores from each line.
######################################################################
p6_filter_strip_alum_and_underscore() {

    p6_filter__string_apply p6_string_strip_alum_and_underscore

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_strip_trailing_slash()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Strip a trailing slash from each line.
######################################################################
p6_filter_strip_trailing_slash() {

    p6_filter__string_apply p6_string_strip_trailing_slash

    p6_return_filter
}
