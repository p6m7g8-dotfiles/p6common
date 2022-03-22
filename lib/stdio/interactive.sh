# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_int__debug()
#
#  Depends:	 p6_die p6_int
#>
######################################################################
p6_int__debug() {
    local msg="$1"

    p6_debug "p6_int: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: code 42 = p6_int_confirm_ask()
#
#  Returns:
#	code - 42
#
#  Depends:	 p6_die p6_int p6_msg
#  Environment:	 TEST_MODE
#>
######################################################################
p6_int_confirm_ask() {

    while [ : ]; do
        p6_msg "Are you sure Y/n?: \c"
        local answer
        read answer

        [ x"${answer}" = x"Y" -o x"${answer}" = x"n" ] && break
    done
    p6_int__debug "confirm_ask(): received [$answer]"

    if [ x"${answer}" = x"n" ]; then
        if [ -n "${TEST_MODE}" ]; then
            p6_msg "Asked to Exit"
            p6_return_code_as_code "42"
        else
            p6_die "42" "Asked to Exit."
        fi
    fi
}

######################################################################
#<
#
# Function: str PASSWORD = p6_int_password_read()
#
#  Returns:
#	str - PASSWORD
#
#  Environment:	 PASSWORD
#>
######################################################################
p6_int_password_read() {

    local PASSWORD
    stty -echo
    read PASSWORD
    stty echo

    p6_return_str "$PASSWORD"
}
