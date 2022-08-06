######################################################################
#<
#
# Function: p6_log(msg)
#
#  Args:
#	msg -
#
#  Environment:	 P6_DFZ_LOG_DISABLED
#>
######################################################################
p6_log() {
    local msg="$*"

    if [ -z "$P6_DFZ_LOG_DISABLED" ]; then
        p6_msg "$msg" >>/tmp/p6/log.log
    fi

    p6_return_void
}

######################################################################
#<
#
# Function: p6_log_disable()
#
#  Environment:	 P6_DFZ_LOG_DISABLED
#>
######################################################################
p6_log_disable() {

    export P6_DFZ_LOG_DISABLED=1
}

######################################################################
#<
#
# Function: p6_log_enable()
#
#  Environment:	 P6_DFZ_LOG_DISABLED
#>
######################################################################
p6_log_enable() {

    unset P6_DFZ_LOG_DISABLED
}
