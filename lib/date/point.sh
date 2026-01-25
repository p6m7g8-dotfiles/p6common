# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_date_point_now_epoch_seconds()
#
#>
#/ Synopsis
#/    Returns the current time as epoch seconds.
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
#/ Synopsis
#/    Returns the current date as YYYYMMDD.
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
#/ Synopsis
#/    Returns today as YYYY-MM-DD.
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
#/ Synopsis
#/    Returns yesterday as YYYYMMDD.
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
#/ Synopsis
#/    Returns tomorrow as YYYYMMDD.
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
#	year - year (YYYY)
#	month - month (1-12)
#
#  Returns:
#	int - day
#
#  Environment:	 NF
#>
#/ Synopsis
#/    Computes the last day number of a given year and month.
######################################################################
p6_date_point_last_day_of_ym() {
    local year="$1"  # year (YYYY)
    local month="$2" # month (1-12)

    local day=$(cal "$month" "$year" | awk 'NF {day=$NF} END {print day}')

    p6_return_int "$day"
}

######################################################################
#<
#
# Function: int first_month = p6_date_point_first_month_of_quarter(quarter)
#
#  Args:
#	quarter - quarter (1-4)
#
#  Returns:
#	int - first_month
#
#>
#/ Synopsis
#/    Returns the first month number for a given quarter.
######################################################################
p6_date_point_first_month_of_quarter() {
    local quarter="$1" # quarter (1-4)

    local first_month=$(((quarter - 1) * 3 + 1))

    p6_return_int "$first_month"
}

######################################################################
#<
#
# Function: int end_month = p6_date_point_last_month_of_quarter(start_month)
#
#  Args:
#	start_month - quarter start month
#
#  Returns:
#	int - end_month
#
#>
#/ Synopsis
#/    Returns the last month number for a quarter given its start month.
######################################################################
p6_date_point_last_month_of_quarter() {
    local start_month="$1" # quarter start month

    local end_month=$((start_month + 2))

    p6_return_int "$end_month"
}
