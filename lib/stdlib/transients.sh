# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_transient__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emits a debug message scoped to transients.
######################################################################
p6_transient__debug() {
    local msg="$1" # debug message

    p6_debug "p6_transient: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: str  = p6_transient_create(dir_name, [len=4])
#
#  Args:
#	dir_name - transient dir name
#	OPTIONAL len - random suffix length [4]
#
#  Returns:
#	str - 
#	str - 
#	str - dir_name
#
#  Environment:	 P6_DIR_TRANSIENTS P6_TEST_TRANSIENT_CREATE_RAND
#>
#/ Synopsis
#/    Creates a transient directory under P6_DIR_TRANSIENTS and returns its path.
######################################################################
p6_transient_create() {
    local dir_name="$1" # transient dir name
    local len="${2:-4}" # random suffix length

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
#	file_name - transient file base name
#
#  Returns:
#	path - file
#
#>
#/ Synopsis
#/    Creates a transient directory and returns a file path inside it.
######################################################################
p6_transient_create_file() {
    local file_name="$1" # transient file base name

    local dir=$(p6_transient_create "$file_name")
    local file="$dir/file"

    p6_return_path "$file"
}

######################################################################
#<
#
# Function: p6_transient_is(dir)
#
#  Args:
#	dir - transient directory path
#
#>
#/ Synopsis
#/    Returns true when dir exists and is managed as a transient.
######################################################################
p6_transient_is() {
    local dir="$1" # transient directory path

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
#	dir - transient directory path
#
#>
#/ Synopsis
#/    Marks a transient directory as persisted.
######################################################################
p6_transient_persist() {
    local dir="$1" # transient directory path

    p6_file_create "$dir/persist"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_transient_persist_un(dir)
#
#  Args:
#	dir - transient directory path
#
#>
#/ Synopsis
#/    Removes the persistence marker from a transient directory.
######################################################################
p6_transient_persist_un() {
    local dir="$1" # transient directory path

    p6_file_rmf "$dir/persist"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_transient_persist_is(dir)
#
#  Args:
#	dir - transient directory path
#
#>
#/ Synopsis
#/    Returns true when a transient directory is marked persisted.
######################################################################
p6_transient_persist_is() {
    local dir="$1" # transient directory path

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
#	dir - transient directory path
#	OPTIONAL handler_name - cleanup handler name []
#
#  Environment:	 P6_TRANSIENT_LOG
#>
#/ Synopsis
#/    Deletes a transient directory unless it is persisted or under cleanup.
######################################################################
p6_transient_delete() {
    local dir="$1"               # transient directory path
    local handler_name="${2:-}"  # cleanup handler name

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
#/ Synopsis
#/    Cleanup handler to delete logged transient directories on exit.
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
#	dir - transient directory path
#
#  Environment:	 P6_TRANSIENT_LOG
#>
#/ Synopsis
#/    Appends a transient directory path to the transient log.
######################################################################
p6_transient__log() {
    local dir="$1" # transient directory path

    p6_transient__debug "__log(): [$dir]"

    p6_file_append "$P6_TRANSIENT_LOG" "$dir"

    p6_return_void
}
