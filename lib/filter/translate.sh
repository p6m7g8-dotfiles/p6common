# shellcheck shell=bash

######################################################################
#<
#
# Function: filter  = p6_filter_translate_glob_to_underscore(glob)
#
#  Args:
#	glob - glob pattern to replace
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Replace a glob pattern with underscores on each line.
######################################################################
p6_filter_translate_glob_to_underscore() {
    local glob="$1" # glob pattern to replace

    p6_filter__string_apply p6_string_replace "$glob" "_" "g"

    p6_return_filter

}

######################################################################
#<
#
# Function: filter  = p6_filter_replace(from, to, [flags=g])
#
#  Args:
#	from - pattern to replace
#	to - replacement string
#	OPTIONAL flags - sed flags [g]
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Replace pattern matches with a replacement string on each line.
######################################################################
p6_filter_replace() {
    local from="$1"      # pattern to replace
    local to="$2"        # replacement string
    local flags="${3:-g}" # sed flags

    p6_filter__string_apply p6_string_replace "$from" "$to" "$flags"

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
#/ Synopsis
#/    Replace parentheses with slashes.
######################################################################
p6_filter_translate_parens_to_slash() {

    p6_filter__string_apply p6_string_replace "[()]" "/" "g"

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
#/ Synopsis
#/    Replace '/!' sequences with '!'.
######################################################################
p6_filter_translate_trailing_slash_bang_to_bang() {

    p6_filter__string_apply p6_string_replace "/!" "!" "g"

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
#/ Synopsis
#/    Replace spaces with underscores.
######################################################################
p6_filter_translate_space_to_underscore() {

    p6_filter__string_apply p6_string_replace " " "_" "g"

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
#/ Synopsis
#/    Replace spaces with tabs.
######################################################################
p6_filter_translate_space_to_tab() {

    local tab=$'\t'
    p6_filter__string_apply p6_string_replace " " "$tab" "g"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_translate_space_to_newline()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Translate spaces into newlines.
######################################################################
p6_filter_translate_space_to_newline() {

    tr ' ' '\n'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_strip_leading_v()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Strip a leading 'v' prefix when present.
######################################################################
p6_filter_strip_leading_v() {

    p6_filter__string_apply p6_string_strip_prefix "v"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_strip_leading_go()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Strip a leading 'go' prefix when present.
######################################################################
p6_filter_strip_leading_go() {

    p6_filter__string_apply p6_string_strip_prefix "go"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_strip_scala3_prefix()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Strip a leading 'scala3-' prefix when present.
######################################################################
p6_filter_strip_scala3_prefix() {

    p6_filter__string_apply p6_string_strip_prefix "scala3-"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_translate_resource_records_label_to_tab()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Replace RESOURCERECORDS with a tab delimiter.
######################################################################
p6_filter_translate_resource_records_label_to_tab() {

    awk '{sub(/RESOURCERECORDS/,"\t"); print}'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_translate_hex_pairs_to_csv()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Insert commas after each pair of hex characters.
######################################################################
p6_filter_translate_hex_pairs_to_csv() {

    sed -e 's/../&,/g'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_translate_words_to_sql_list([sep=|])
#
#  Args:
#	OPTIONAL sep - field separator [|]
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Convert delimited words into a SQL list tuple.
######################################################################
p6_filter_translate_words_to_sql_list() {
    local sep="${1:-|}" # field separator

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
#/ Synopsis
#/    Replace tabs with pipe separators.
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
#	arg - prefix string
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Prefix each line with the provided string.
######################################################################
p6_filter_translate_start_to_arg() {
    local arg="$1" # prefix string

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
#>
#/ Synopsis
#/    Replace empty pipe-delimited fields with NULL.
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
#>
#/ Synopsis
#/    Replace quoted 'NULL' tokens with bare NULL.
######################################################################
p6_filter_translate_quoted_null_to_null() {

    sed -e "s,'NULL',NULL,g"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_convert_multispace_delimited_columns_to_pipes()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Convert multi-space-delimited columns to pipes.
######################################################################
p6_filter_convert_multispace_delimited_columns_to_pipes() {

    sed 's/\([[:alnum:]\/-]*\) \{1,\}\([^ ]*\) \{1,\}\(.*severity\) \{1,\}\(.*\)$/\1|\2|\3|\4/'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_translate_first_field_slash_to_pipe()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Replace the first field's slash with a pipe.
######################################################################
p6_filter_translate_first_field_slash_to_pipe() {

    sed 's/\([^|]*\)\/\([^|]*\)|/\1|\2|/'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_insert_null_at_position(position)
#
#  Args:
#	position - 1-based field position
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Ensure a NULL field exists at the given position.
######################################################################
p6_filter_insert_null_at_position() {
    local position=$1 # 1-based field position

    awk -v pos="$position" -F'|' 'BEGIN {OFS=FS} {if (NF < pos) for (i=NF+1; i<=pos; i++) $i="NULL"; print}'

    p6_return_filter
}
