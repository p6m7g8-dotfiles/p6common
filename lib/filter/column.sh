# shellcheck shell=bash

#
# Filters
#  Filters expect to process stdin and send output to stdout
#  aka someone will say ..... | p6_filter_* | ...
#

######################################################################
#<
#
# Function: str action = p6_filter_column_pluck__all_to_action(action)
#
#  Args:
#	action -
#
#  Returns:
#	str - action
#
#>
#/ Synopsis
#/    Build an awk action that prints the full line.
######################################################################
p6_filter_column_pluck__all_to_action() {

    local action='{ print $0 }' # awk action for full line

    p6_return_str "$action"
}

######################################################################
#<
#
# Function: str action = p6_filter_column_pluck__list_to_action(columns)
#
#  Args:
#	columns - column list (comma-separated)
#
#  Returns:
#	str - action
#
#  Environment:	 IFS
#>
#/ Synopsis
#/    Build an awk action for a comma-separated column list.
######################################################################
p6_filter_column_pluck__list_to_action() {
    local columns="$1" # column list (comma-separated)

    local col
    local old_IFS="$IFS"
    local action="{ print "
    IFS=","
    for col in $(p6_echo "$columns"); do
        action="$action, \"$split\", \$$col"
    done
    action="$action }"
    action=$(p6_echo "$action" | sed -e 's/print ,/print/' -e 's/print "-",/print/')
    IFS="$old_IFS"

    p6_return_str "$action"
}

######################################################################
#<
#
# Function: str action = p6_filter_column_pluck__range_to_action(columns)
#
#  Args:
#	columns - column range (start-end)
#
#  Returns:
#	str - action
#	str - action
#
#>
#/ Synopsis
#/    Build an awk action for a column range.
######################################################################
p6_filter_column_pluck__range_to_action() {
    local columns="$1" # column range (start-end)

    local n=$(p6_echo "$columns" | awk -F"-" '{ print $1 }') # range start
    local m=$(p6_echo "$columns" | awk -F"-" '{ print $2 }') # range end
    if p6_string_blank "$m"; then
        local action="{ for (i=${n}; i<=NF; i++) { printf \"%s%s\", (i==${n} ? \"\" : OFS), \$i } print \"\" }"
        p6_return_str "$action"
        return
    fi
    local result="\$$n"
    n=$(p6_math_inc "$n" "1")
    while p6_math_lte "$n" "$m"; do
        result="$result,\$$n"
        n=$(p6_math_inc "$n" "1")
    done
    local action="{ print $result }"

    p6_return_str "$action"
}

######################################################################
#<
#
# Function: str action = p6_filter_column_pluck__column_to_action(columns)
#
#  Args:
#	columns - column index
#
#  Returns:
#	str - action
#
#>
#/ Synopsis
#/    Build an awk action for a single column.
######################################################################
p6_filter_column_pluck__column_to_action() {
    local columns="$1" # column index

    local action="{ print \$$columns }"

    p6_return_str "$action"
}

######################################################################
#<
#
# Function: filter  = p6_filter_column_pluck(columns, [split= ], [selector=])
#
#  Args:
#	columns - column spec (list, range, or index)
#	OPTIONAL split - field separator [ ]
#	OPTIONAL selector - optional line selector []
#
#  Returns:
#	filter - 
#
#  Environment:	 P6_EXIT_ARGS
#>
#/ Synopsis
#/    Extract columns from delimited input.
######################################################################
p6_filter_column_pluck() {
    local columns="$1"   # column spec (list, range, or index)
    local split="${2:- }" # field separator
    local selector="${3:-}" # optional line selector

    local action

    case "$columns" in
    0) action=$(p6_filter_column_pluck__all_to_action) ;;
    *,*) action=$(p6_filter_column_pluck__list_to_action "$columns") ;;
    *-*) action=$(p6_filter_column_pluck__range_to_action "$columns") ;;
    [1-9]*) action=$(p6_filter_column_pluck__column_to_action "$columns") ;;
    *) p6_die "$P6_EXIT_ARGS" "invalid column specification" ;;
    esac

    if p6_string_blank "$selector"; then
        awk -F"$split" "$action"
    else
        awk -F"$split" -v k="$selector" "\$0 ~ k $action"
    fi

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_column_pair_to_kv(key_column, value_column, [sep= ], [kv_sep==])
#
#  Args:
#	key_column - key column index
#	value_column - value column index
#	OPTIONAL sep - field separator [ ]
#	OPTIONAL kv_sep - key/value separator [=]
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Emit key/value pairs from two columns.
######################################################################
p6_filter_column_pair_to_kv() {
    local key_column="$1"   # key column index
    local value_column="$2" # value column index
    local sep="${3:- }"     # field separator
    local kv_sep="${4:-=}"  # key/value separator

    if p6_string_blank "$sep"; then
        awk -v k="$key_column" -v v="$value_column" -v kv="$kv_sep" '{print $k kv $v}'
    else
        awk -F"$sep" -v k="$key_column" -v v="$value_column" -v kv="$kv_sep" '{print $k kv $v}'
    fi

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_column_swap([sep=\t])
#
#  Args:
#	OPTIONAL sep - field separator [\t]
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Swap the first two columns.
######################################################################
p6_filter_column_swap() {
    local sep="${1:-\t}" # field separator

    awk -v sep="$sep" '{print $2, sep, $1}'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_columns_count([sep=\t])
#
#  Args:
#	OPTIONAL sep - field separator [\t]
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Print the number of columns in the first row.
######################################################################
p6_filter_columns_count() {
    local sep="${1:-\t}" # field separator

    awk -F"$sep" '{print NF; exit}'

    p6_return_filter
}
