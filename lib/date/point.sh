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
