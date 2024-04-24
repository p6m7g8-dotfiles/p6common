# shellcheck shell=bash

#
# Filters
#  Filters expect to process stdin and send output to stdout
#  aka someone will say ..... | p6_filter_* | ...
#

######################################################################
#<
#
# Function: p6_filter_column_pluck()
#
#  Environment:	 OFS
#>
######################################################################
p6_filter_column_pluck() {
    local n="$1"
    local split="${2:- }"
    local selector="${3:-}"

    local action
    if p6_string_eq "$n" "0"; then
        action='{ print $0 }' 
    elif p6_string_blank "$n"; then
        action="{ for (i = $n; i <= NF; i++) printf \"%s%s\", \$$i, (i < NF ? OFS : ORS) }"
    else
        action="{ print \$$n }" 
    fi

    if ! p6_string_blank "$selector"; then
        awk -F"$split" -v k="$selector" "\$0 ~ k { $action }"
    else
        awk -F"$split" "$action"
    fi
}

######################################################################
#<
#
# Function: p6_filter_column_swap([sep=\t])
#
#  Args:
#	OPTIONAL sep - [\t]
#
#>
######################################################################
p6_filter_column_swap() {
    local sep="${1:-\t}"

    awk "{ print $2 \"$sep\" $1}"
}

######################################################################
#<
#
# Function: p6_filter_columns_count([sep=\t])
#
#  Args:
#	OPTIONAL sep - [\t]
#
#>
######################################################################
p6_filter_columns_count() {
    local sep="${1:-\t}"

    awk -F"$sep" '{print NF; exit}'
}
