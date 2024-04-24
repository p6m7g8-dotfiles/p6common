# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_date_point_now_epoch_seconds()
#
#>
######################################################################
p6_date_point_now_epoch_seconds() {

    local epoch_seconds=$(p6_date__date "%s")

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

    local dt=$(p6_date__date "%Y%m%d")

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

    local fmt="+%Y%m%d"

    local dt=$(p6_date__date "$fmt" "-1d")

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

    local fmt="+%Y%m%d"

    local dt=$(p6_date__date "$fmt" "1d")

    p6_return_date "$dt"
}
