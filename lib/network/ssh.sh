# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_ssh__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emits a debug message scoped to SSH helpers.
######################################################################
p6_ssh__debug() {
    local msg="$1" # debug message

    p6_debug "p6_ssh: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_ssh_key_check(priv, test_pub)
#
#  Args:
#	priv - private key file
#	test_pub - public key file to compare
#
#>
#/ Synopsis
#/    Compares a private key to a public key for a match.
######################################################################
p6_ssh_key_check() {
    local priv="$1"     # private key file
    local test_pub="$2" # public key file to compare

    local dir=$(p6_transient_create "ssh-keygen")

    local pub_from_priv="$dir/pub_from_priv"
    local pub_from_pub="$dir/pub_from_pub"
    ssh-keygen -y -e -f "$priv" >$pub_from_priv
    ssh-keygen -y -e -f "$test_pub" >$pub_from_pub

    cmp -s $pub_from_priv $pub_from_pub
    local rc=$?

    p6_transient_delete "$dir"

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: p6_ssh_key_fingerprint(key_file_pub)
#
#  Args:
#	key_file_pub - public key file
#
#>
#/ Synopsis
#/    Prints the fingerprint for a public key.
######################################################################
p6_ssh_key_fingerprint() {
    local key_file_pub="$1" # public key file

    p6_run_read_cmd ssh-keygen -lf $key_file_pub

    p6_return_void
}

######################################################################
#<
#
# Function: p6_ssh_key_add(key_file_priv)
#
#  Args:
#	key_file_priv - private key file
#
#>
#/ Synopsis
#/    Adds a private key to the ssh-agent.
######################################################################
p6_ssh_key_add() {
    local key_file_priv="$1" # private key file

    local flag_K
    local os=$(p6_os_name)
    case $os in
    Darwin) flag_K=-K ;;
    esac

    p6_run_write_cmd ssh-add $flag_K $key_file_priv

    p6_return_void
}

######################################################################
#<
#
# Function: p6_ssh_key_delete(key_file_priv)
#
#  Args:
#	key_file_priv - private key file
#
#>
#/ Synopsis
#/    Removes all keys from ssh-agent (with OS-specific flags).
######################################################################
p6_ssh_key_delete() {
    local key_file_priv="$1" # private key file

    local flag_K
    local os=$(p6_os_name)
    case $os in
    Darwin) flag_K=-K ;;
    esac

    p6_run_write_cmd ssh-add -D $flag_K $key_file_priv

    p6_return_void
}

######################################################################
#<
#
# Function: p6_ssh_key_pub_from_priv(key_file_priv, [key_file_pub=${key_file_priv])
#
#  Args:
#	key_file_priv - private key file
#	OPTIONAL key_file_pub - public key file [${key_file_priv]
#
#>
#/ Synopsis
#/    Derives a public key from a private key file.
######################################################################
p6_ssh_key_pub_from_priv() {
    local key_file_priv="$1"               # private key file
    local key_file_pub="${2:-${key_file_priv}.pub}" # public key file

    p6_run_write_cmd ssh-keygen -y -f $key_file_priv >$key_file_pub

    p6_return_void
}

######################################################################
#<
#
# Function: p6_ssh_key_make(key_file_priv)
#
#  Args:
#	key_file_priv - private key file
#
#>
#/ Synopsis
#/    Creates a new ed25519 SSH key pair.
######################################################################
p6_ssh_key_make() {
    local key_file_priv="$1" # private key file

    p6_run_write_cmd ssh-keygen -t ed25519 -f $key_file_priv -N "''"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_ssh_key_remove(key_file_priv, [key_file_pub=${key_file_priv])
#
#  Args:
#	key_file_priv - private key file
#	OPTIONAL key_file_pub - public key file [${key_file_priv]
#
#>
#/ Synopsis
#/    Removes a private key and its associated public key.
######################################################################
p6_ssh_key_remove() {
    local key_file_priv="$1"               # private key file
    local key_file_pub="${2:-${key_file_priv}.pub}" # public key file

    p6_file_rmf $key_file_pub
    p6_file_rmf $key_file_priv

    p6_return_void
}

######################################################################
#<
#
# Function: p6_ssh_keys_chmod(key_file_priv)
#
#  Args:
#	key_file_priv - private key file
#
#>
#/ Synopsis
#/    Sets secure permissions on the private key and its directory.
######################################################################
p6_ssh_keys_chmod() {
    local key_file_priv="$1" # private key file

    local dir=$(p6_uri_path "$key_file_priv")

    p6_run_write_cmd chmod 700 $dir
    p6_run_write_cmd chmod 600 $key_file_priv
    #    p6_run_write_cmd chmod 644 $key_file_pub

    p6_return_void
}
