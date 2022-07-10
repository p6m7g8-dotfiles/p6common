# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_dt__debug()
#
#>
######################################################################
p6_dt__debug() {
    local msg="$1"

    p6_debug "p6_dt: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: str dt = p6_dt__date(fmt, offset)
#
#  Args:
#	fmt -
#	offset -
#
#  Returns:
#	str - dt
#
#  Environment:	 BSD
#>
######################################################################
p6_dt__date() {
    local fmt="$1"
    local offset="$2"

    p6_dt__debug "_date(): date \"$fmt\" \"$offset\""

    local dt
    if [ -z "$offset" ]; then
        dt=$(date $fmt)
    else
        local os_name=$(p6_os_name)
        case $os_name in
        Darwin | BSD)
            oft_flag="-v"
            oft_val="${oft}d"
            ;;
        *)
            oft_flag="--date"
            oft_val="${oft} day ago"
            ;;
        esac
        dt=$(date $fmt $oft)
    fi

    p6_return_str "$dt"
}

######################################################################
#<
#
# Function: size_t epoch_seconds = p6_dt_now_epoch_seconds()
#
#  Returns:
#	size_t - epoch_seconds
#
#>
######################################################################
p6_dt_now_epoch_seconds() {

    local epoch_seconds=$(p6_dt__date "+%s")

    p6_return_size_t "$epoch_seconds"
}

######################################################################
#<
#
# Function: str dt = p6_dt_now()
#
#  Returns:
#	str - dt
#
#>
######################################################################
p6_dt_now() {

    local dt=$(p6_dt__date "+%Y%m%d")

    p6_return_str "$dt"
}

######################################################################
#<
#
# Function: str dt = p6_dt_yesterday()
#
#  Returns:
#	str - dt
#
#>
######################################################################
p6_dt_yesterday() {

    local fmt="+%Y%m%d"

    local dt=$(p6_dt__date "$fmt" "-1")

    p6_return_str "$dt"
}

######################################################################
#<
#
# Function: str dt = p6_dt_tomorrow()
#
#  Returns:
#	str - dt
#
#>
######################################################################
p6_dt_tomorrow() {

    local fmt="+%Y%m%d"

    local dt=$(p6_dt__date "$fmt" "1")

    p6_return_str "$dt"
}

######################################################################
#<
#
# Function: size_t modified_epoch_seconds = p6_dt_mtime(file)
#
#  Args:
#	file -
#
#  Returns:
#	size_t - modified_epoch_seconds
#
#>
######################################################################
p6_dt_mtime() {
    local file="$1"

    local modified_epoch_seconds=$(stat -f "%m" $file)

    p6_return_size_t "$modified_epoch_seconds"
}
