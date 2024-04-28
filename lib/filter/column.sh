# shellcheck shell=bash

#
# Filters
#  Filters expect to process stdin and send output to stdout
#  aka someone will say ..... | p6_filter_* | ...
#

######################################################################
#<
#
# Function: str action = p6_filter_column_pluck__all_to_action()
#
#  Returns:
#	str - action
#
#>
######################################################################
p6_filter_column_pluck__all_to_action() {

    local action='{ print $0 }'

    p6_return_str "$action"
}

######################################################################
#<
#
# Function: str action = p6_filter_column_pluck__list_to_action(columns)
#
#  Args:
#	columns -
#
#  Returns:
#	str - action
#
#  Environment:	 IFS _IFS
#>
######################################################################
p6_filter_column_pluck__list_to_action() {
    local columns="$1"

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
#	columns -
#
#  Returns:
#	str - action
#
#>
######################################################################
p6_filter_column_pluck__range_to_action() {
    local columns="$1"

    local n=$(p6_echo "$columns" | awk -F"-" '{ print $1 }')
    local m=$(p6_echo "$columns" | awk -F"-" '{ print $2 }')
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
#	columns -
#
#  Returns:
#	str - action
#
#>
######################################################################
p6_filter_column_pluck__column_to_action() {
    local columns="$1"

    local action="{ print \$$columns }"

    p6_return_str "$action"
}

######################################################################
#<
#
# Function: filter  = p6_filter_column_pluck(columns, [split= ], [selector=])
#
#  Args:
#	columns -
#	OPTIONAL split - [ ]
#	OPTIONAL selector - []
#
#  Returns:
#	filter - 
#
#  Environment:	 P6_EXIT_ARGS
#>
######################################################################
p6_filter_column_pluck() {
    local columns="$1"
    local split="${2:- }"
    local selector="${3:-}"

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
# Function: filter  = p6_filter_column_swap([sep=\t])
#
#  Args:
#	OPTIONAL sep - [\t]
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_column_swap() {
    local sep="${1:-\t}"

    awk -v sep="$sep" '{print $2, sep, $1}'

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_columns_count([sep=\t])
#
#  Args:
#	OPTIONAL sep - [\t]
#
#  Returns:
#	filter - 
#
#>
######################################################################
p6_filter_columns_count() {
    local sep="${1:-\t}"

    awk -F"$sep" '{print NF; exit}'

    p6_return_filter
}
