# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_filter_translate_glob_to_underscore()
#
#>
######################################################################
p6_filter_translate_glob_to_underscore() {
    local glob="$1"

    sed -e "s,$glob,_,g"
}

######################################################################
#<
#
# Function: p6_filter_translate_parens_to_slash()
#
#>
######################################################################
p6_filter_translate_parens_to_slash() {

    sed -e 's,(,/,g' -e 's,),/,g'
}

######################################################################
#<
#
# Function: p6_filter_translate_trailing_slash_bang_to_bang()
#
#>
######################################################################
p6_filter_translate_trailing_slash_bang_to_bang() {

    sed -e 's,/\!,!,g'
}

######################################################################
#<
#
# Function: p6_filter_translate_space_to_underscore()
#
#>
######################################################################
p6_filter_translate_space_to_underscore() {

    sed -e 's, ,_,g'
}

######################################################################
#<
#
# Function: p6_filter_translate_space_to_tab()
#
#>
######################################################################
p6_filter_translate_space_to_tab() {

    sed -e "s, ,\t,g"
}
