# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_transient__debug()
#
#>
######################################################################
p6_transient__debug() {
    local msg="$1"

    p6_debug "p6_transient: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: str  = p6_transient_create(dir_name, [len=4])
#
#  Args:
#	dir_name -
#	OPTIONAL len - [4]
#
#  Returns:
#	str - 
#	str - 
#	str - dir_name
#
#  Environment:	 P6_DIR_TRANSIENTS P6_TEST_TRANSIENT_CREATE_RAND
#>
######################################################################
p6_transient_create() {
    local dir_name="$1"
    local len="${2:-4}"

    if p6_string_blank "$dir_name"; then
        p6_return_str ""
    else
        local rand
        if ! p6_string_blank "$P6_TEST_TRANSIENT_CREATE_RAND"; then
            rand=TEST_MODE
        else
            rand=$(p6_token_random "$len")
        fi

        dir_name=$P6_DIR_TRANSIENTS/$dir_name/$rand

        if p6_dir_exists "$dir_name"; then
            p6_transient__log "$dir_name"
            p6_return_str ""
        else
            p6_transient__debug "create(): CREATED [dir_name=$dir_name] [len=$len]"
            p6_dir_mk "$dir_name"
            p6_transient__log "$dir_name"

            p6_return_str "$dir_name"
        fi
    fi
}

######################################################################
#<
#
# Function: path file = p6_transient_create_file(file_name)
#
#  Args:
#	file_name -
#
#  Returns:
#	path - file
#
#>
######################################################################
p6_transient_create_file() {
    local file_name="$1"

    local dir=$(p6_transient_create "$file_name")
    local file="$dir/file"

    p6_return_path "$file"
}

######################################################################
#<
#
# Function: code rc = p6_transient_is(dir)
#
#  Args:
#	dir -
#
#  Returns:
#	code - rc
#
#>
######################################################################
p6_transient_is() {
    local dir="$1"

    p6_dir_exists "$dir"
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: p6_transient_persist(dir)
#
#  Args:
#	dir -
#
#>
######################################################################
p6_transient_persist() {
    local dir="$1"

    p6_file_create "$dir/persist"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_transient_persist_un(dir)
#
#  Args:
#	dir -
#
#>
######################################################################
p6_transient_persist_un() {
    local dir="$1"

    p6_file_rmf "$dir/persist"

    p6_return_void
}

######################################################################
#<
#
# Function: code rc = p6_transient_persist_is(dir)
#
#  Args:
#	dir -
#
#  Returns:
#	code - rc
#
#>
######################################################################
p6_transient_persist_is() {
    local dir="$1"

    p6_file_exists "$dir/persist"
    local rc=$?

    p6_return_code_as_code "$rc"
}

# Have a good reason to call this yourself
######################################################################
#<
#
# Function: p6_transient_delete(dir, [handler_name=])
#
#  Args:
#	dir -
#	OPTIONAL handler_name - []
#
#  Environment:	 P6_TRANSIENT_LOG
#>
######################################################################
p6_transient_delete() {
    local dir="$1"
    local handler_name="${2:-}"

    if p6_file_exists "$dir"; then
        dir=$(p6_uri_path "$dir")
    fi

    if p6_string_eq "$handler_name" "cleanup"; then
        p6_transient__debug "delete($P6_TRANSIENT_LOG): [handler_name=$handler_name] [dir=$dir]"
        p6_dir_rmrf "$dir"
    else
        if ! p6_transient_persist_is "$dir"; then
            p6_transient__debug "delete($P6_TRANSIENT_LOG): [dir=$dir]"
            p6_dir_rmrf "$dir"
        fi
    fi

    p6_return_void
}

## Internal Only
######################################################################
#<
#
# Function: p6_transient__cleanup()
#
#  Environment:	 P6_TRANSIENT_LOG
#>
######################################################################
p6_transient__cleanup() {

    local dir
    for dir in $(p6_file_display "$P6_TRANSIENT_LOG"); do
        p6_transient_delete "$dir" "cleanup"
    done

    p6_file_rmf "$P6_TRANSIENT_LOG"

    #    p6_die "$P6_TRUE" "# p6_transient__cleanup"

    p6_return_void
}
trap p6_transient__cleanup 0 1 2 3 6 14 15

######################################################################
#<
#
# Function: p6_transient__log(dir)
#
#  Args:
#	dir -
#
#  Environment:	 P6_TRANSIENT_LOG
#>
######################################################################
p6_transient__log() {
    local dir="$1"

    p6_transient__debug "__log(): [$dir]"

    p6_file_append "$P6_TRANSIENT_LOG" "$dir"

    p6_return_void
}
