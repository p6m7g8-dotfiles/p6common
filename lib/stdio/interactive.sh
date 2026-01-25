# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_int__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for interactive helpers.
######################################################################
p6_int__debug() {
    local msg="$1" # debug message

    p6_debug "p6_int: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_int_confirm_ask()
#
#  Environment:	 TEST_MODE
#>
#/ Synopsis
#/    Prompt for Y/n confirmation and exit on "n".
######################################################################
p6_int_confirm_ask() {

    while [ : ]; do
        p6_msg "Are you sure Y/n?: \c"
        local answer
        read answer

        p6_string_eq_any "$answer" "Y" "n" && break
    done
    p6_int__debug "confirm_ask(): received [$answer]"

    if p6_string_eq "$answer" "n"; then
        if p6_string_blank_NOT "$TEST_MODE"; then
            p6_msg "Asked to Exit"
            p6_return_code_as_code "42"
        else
            p6_die "P6_EXIT_ASKED" "Asked to Exit."
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
#/ Synopsis
#/    Read a password from stdin without echo.
######################################################################
p6_int_password_read() {

    local PASSWORD
    stty -echo
    read PASSWORD
    stty echo

    p6_return_str "$PASSWORD"
}
