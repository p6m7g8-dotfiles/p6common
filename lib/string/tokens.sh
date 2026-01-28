# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_token__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for token helpers.
######################################################################
p6_token__debug() {
    local msg="$1" # debug message

    p6_debug "p6_token: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: str hashed = p6_token_hash(string)
#
#  Args:
#	string - input string
#
#  Returns:
#	str - hashed
#
#>
#/ Synopsis
#/    Compute an MD5 hash of the provided string.
######################################################################
p6_token_hash() {
    local string="$1" # input string

    local hashed=
    if p6_string_blank_NOT "$string"; then
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
#	len - token length
#
#  Returns:
#	str - token
#
#>
#/ Synopsis
#/    Generate a random alphanumeric token of the given length.
######################################################################
p6_token_random() {
    local len="$1" # token length

    local token
    if p6_string_blank_NOT "$len"; then
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
#	len - password length
#
#  Returns:
#	str - pass
#
#>
#/ Synopsis
#/    Generate a random password of the given length.
######################################################################
p6_token_passwd() {
    local len="$1" # password length

    local pass=$(p6_token_random "$len")

    p6_return_str "$pass"
}

######################################################################
#<
#
# Function: p6_token_sha256(string)
#
#  Args:
#	string - input string
#
#>
#/ Synopsis
#/    Print the SHA-256 hash of the provided string.
######################################################################
p6_token_sha256() {
    local string="$1" # input string

    p6_echo -n "$string" | sha256sum | cut -d' ' -f1
}

######################################################################
#<
#
# Function: p6_token_encode_base64(string)
#
#  Args:
#	string - input string
#
#>
#/ Synopsis
#/    Base64-encode the provided string.
######################################################################
p6_token_encode_base64() {
    local string="$1" # input string

    p6_echo -n "$string" | base64
}
