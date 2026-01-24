######################################################################
#<
#
# Function: p6_verbose(level, ...)
#
#  Args:
#	level - minimum verbosity before output
#	... - 
#
#  Environment:	 P6_VERBOSE
#>
######################################################################
p6_verbose() {
    local level="$1" # minimum verbosity before output
    if [ -z "$level" ]; then
        p6_return_void
        return
    fi
    shift

    if [ -n "$level" ]; then
        P6_VERBOSE=${P6_VERBOSE:-0}

        case $level in
        [0-9]*)
            if [ $P6_VERBOSE -ne 0 ] && [ \( $level -gt $P6_VERBOSE -o $level -eq $P6_VERBOSE \) ]; then
                p6_msg "$@"
            fi
            ;;
        esac
    fi

    p6_return_void
}
