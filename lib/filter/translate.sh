# shellcheck shell=bash

######################################################################
#<
#
# Function: filter  = p6_filter_translate_glob_to_underscore()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_translate_glob_to_underscore() {
    local glob="$1"

    sed -e "s,$glob,_,g"

    p6_return_filter

}

######################################################################
#<
#
# Function: filter  = p6_filter_translate_parens_to_slash()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_translate_parens_to_slash() {

    sed -e 's,(,/,g' -e 's,),/,g'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_translate_trailing_slash_bang_to_bang()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_translate_trailing_slash_bang_to_bang() {

    sed -e 's,/\!,!,g'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_translate_space_to_underscore()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_translate_space_to_underscore() {

    sed -e 's, ,_,g'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_translate_space_to_tab()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_translate_space_to_tab() {

    sed -e "s, ,\t,g"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_translate_words_to_sql_list([sep=|])
#
#  Args:
#	OPTIONAL sep - [|]
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_translate_words_to_sql_list() {
    local sep="${1:-|}"

    sed -e "s/|/','/g"

    p6_return_filter
}
