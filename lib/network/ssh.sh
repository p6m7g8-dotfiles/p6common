# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_ssh__debug()
#
#>
######################################################################
p6_ssh__debug() {
    local msg="$1"

    p6_debug "p6_ssh: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: code rc = p6_ssh_key_check(priv, test_pub)
#
#  Args:
#	priv -
#	test_pub -
#
#  Returns:
#	code - rc
#
#>
######################################################################
p6_ssh_key_check() {
    local priv="$1"
    local test_pub="$2"

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
#	key_file_pub -
#
#>
######################################################################
p6_ssh_key_fingerprint() {
    local key_file_pub="$1"

    p6_run_read_cmd ssh-keygen -lf $key_file_pub

    p6_return_void
}

######################################################################
#<
#
# Function: p6_ssh_key_add(key_file_priv)
#
#  Args:
#	key_file_priv -
#
#>
######################################################################
p6_ssh_key_add() {
    local key_file_priv="$1"

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
#	key_file_priv -
#
#>
######################################################################
p6_ssh_key_delete() {
    local key_file_priv="$1"

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
#	key_file_priv -
#	OPTIONAL key_file_pub - [${key_file_priv]
#
#>
######################################################################
p6_ssh_key_pub_from_priv() {
    local key_file_priv="$1"
    local key_file_pub="${2:-${key_file_priv}.pub}"

    p6_run_write_cmd ssh-keygen -y -f $key_file_priv >$key_file_pub

    p6_return_void
}

######################################################################
#<
#
# Function: p6_ssh_key_make(key_file_priv)
#
#  Args:
#	key_file_priv -
#
#>
######################################################################
p6_ssh_key_make() {
    local key_file_priv="$1"

    p6_run_write_cmd ssh-keygen -t ed25519 -f $key_file_priv -N "''"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_ssh_key_remove(key_file_priv, [key_file_pub=${key_file_priv])
#
#  Args:
#	key_file_priv -
#	OPTIONAL key_file_pub - [${key_file_priv]
#
#>
######################################################################
p6_ssh_key_remove() {
    local key_file_priv="$1"
    local key_file_pub="${2:-${key_file_priv}.pub}"

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
#	key_file_priv -
#
#>
######################################################################
p6_ssh_keys_chmod() {
    local key_file_priv="$1"

    local dir=$(p6_uri_path "$key_file_priv")

    p6_run_write_cmd chmod 700 $dir
    p6_run_write_cmd chmod 600 $key_file_priv
    #    p6_run_write_cmd chmod 644 $key_file_pub

    p6_return_void
}
