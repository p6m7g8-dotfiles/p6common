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
#  Environment:	 NULL
#>
######################################################################
p6_filter_translate_words_to_sql_list() {
    local sep="${1:-|}"

    awk -v sep="$sep" -F"$sep" '{
        printf "(";
        for (i=1; i<=NF; i++) {
            if ($i == "NULL" || $i == "")
                printf (i==NF ? "NULL" : "NULL, ");
            else
                printf (i==NF ? "'\''%s'\''" : "'\''%s'\'', ", $i);
        }
        printf ")\n";
    }'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_translate_tab_to_pipe()
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_translate_tab_to_pipe() {

    sed -e 's,\t,|,g'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_translate_start_to_arg(arg)
#
#  Args:
#	arg -
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_translate_start_to_arg() {
    local arg="$1"

    sed -e "s,^,$arg,g"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_translate_blank_to_null()
#
#  Returns:
#	filter - 
#
#  Environment:	 NULL
#>
######################################################################
p6_filter_translate_blank_to_null() {

    sed -e ':a' -e 's/||/|NULL|/g; t a' -e 's/^|/NULL|/' -e 's/|$/|NULL/'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_translate_quoted_null_to_null()
#
#  Returns:
#	filter - 
#
#  Environment:	 NULL
#>
######################################################################
p6_filter_translate_quoted_null_to_null() {

    sed -e "s,'NULL',NULL,g"

    p6_return_filter
}
