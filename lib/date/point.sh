# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_date_point_now_epoch_seconds()
#
#>
######################################################################
p6_date_point_now_epoch_seconds() {

    local epoch_seconds=$(p6_date_fmt__date "" "" "%s" "" "")

    p6_return_date "$epoch_seconds"
}

######################################################################
#<
#
# Function: p6_date_point_now_ymd()
#
#>
######################################################################
p6_date_point_now_ymd() {

    local dt=$(p6_date_fmt__date "" "" "%Y%m%d" "" "")

    p6_return_date "$dt"
}

######################################################################
#<
#
# Function: p6_date_point_today_ymd()
#
#>
######################################################################
p6_date_point_today_ymd() {

    local dt=$(p6_date_fmt__date "" "" "%Y-%m-%d" "" "")

    p6_return_date "$dt"
}

######################################################################
#<
#
# Function: p6_date_point_yesterday_ymd()
#
#>
######################################################################
p6_date_point_yesterday_ymd() {

    local dt=$(p6_date_fmt__date "" "" "%Y%m%d" "-1d" "")

    p6_return_date "$dt"
}

######################################################################
#<
#
# Function: p6_date_point_tomorrow_ymd()
#
#>
######################################################################
p6_date_point_tomorrow_ymd() {

    local dt=$(p6_date_fmt__date "" "" "%Y%m%d" "+1d" "")

    p6_return_date "$dt"
}

######################################################################
#<
#
# Function: int day = p6_date_point_last_day_of_ym(year, month)
#
#  Args:
#	year -
#	month -
#
#  Returns:
#	int - day
#
#>
######################################################################
p6_date_point_last_day_of_ym() {
    local year="$1"
    local month="$2"

    local day=$(cal "$year" "$month" | tail -2 | grep "[0-9]" | awk '{print $NF}')

    p6_return_int "$day"
}

######################################################################
#<
#
# Function: int first_month = p6_date_point_first_month_of_quarter(quarter)
#
#  Args:
#	quarter -
#
#  Returns:
#	int - first_month
#
#>
######################################################################
p6_date_point_first_month_of_quarter() {
    local quarter="$1"

    local first_month=$(((quarter - 1) * 3 + 1))

    p6_return_int "$first_month"
}

######################################################################
#<
#
# Function: int end_month = p6_date_point_last_month_of_quarter(start_month)
#
#  Args:
#	start_month -
#
#  Returns:
#	int - end_month
#
#>
######################################################################
p6_date_point_last_month_of_quarter() {
    local start_month="$1"

    local end_month=$((start_month + 2))

    p6_return_int "$end_month"
}
