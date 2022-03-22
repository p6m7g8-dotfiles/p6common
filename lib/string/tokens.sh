# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_token__debug()
#
#  Depends:	 p6_string p6_token
#>
######################################################################
p6_token__debug() {
    local msg="$1"

    p6_debug "p6_token: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: str hashed = p6_token_hash(string)
#
#  Args:
#	string -
#
#  Returns:
#	str - hashed
#
#  Depends:	 p6_string p6_token
#>
######################################################################
p6_token_hash() {
    local string="$1"

    local hashed=
    if ! p6_string_blank "$string"; then
        if command -v md5 >/dev/null 2>&1; then
            hashed=$(p6_echo "$string" | md5)
        else
            hashed=$(p6_echo "$string" | md5sum | sed -e 's, .*,,')
        fi
    fi

    p6_return_str "$hashed"
}

######################################################################
#<
#
# Function: str token = p6_token_random(len)
#
#  Args:
#	len -
#
#  Returns:
#	str - token
#
#  Depends:	 p6_string p6_token
#  Environment:	 LC_ALL
#>
######################################################################
p6_token_random() {
    local len="$1"

    local token
    if ! p6_string_blank "$len"; then
        token=$(cat /dev/urandom | LC_ALL=C tr -dc a-zA-Z0-9 | head -c $len)
    fi

    p6_return_str "$token"
}

######################################################################
#<
#
# Function: str pass = p6_token_passwd(len)
#
#  Args:
#	len -
#
#  Returns:
#	str - pass
#
#>
######################################################################
p6_token_passwd() {
    local len="$1"

    local pass=$(p6_token_random "$len")

    p6_return_str "$pass"
}
