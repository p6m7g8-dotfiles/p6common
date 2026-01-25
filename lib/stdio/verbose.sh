######################################################################
#<
#
# Function: p6_verbose(level, ...)
#
#  Args:
#	level - minimum verbosity before output
#	... - message text
#
#  Environment:	 P6_VERBOSE
#>
#/ Synopsis
#/    Print messages when verbosity meets the required level.
######################################################################
p6_verbose() {
    local level="$1" # minimum verbosity before output
    if p6_string_blank "$level"; then
        p6_return_void
        return
    fi
    shift # message text

    if p6_string_blank_NOT "$level"; then
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
