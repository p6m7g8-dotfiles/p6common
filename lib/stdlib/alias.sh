# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_alias__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for alias helpers.
######################################################################
p6_alias__debug() {
    local msg="$1" # debug message

    p6_debug "p6_alias: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_alias_cd_dirs(dir)
#
#  Args:
#	dir - directory path
#
#>
#/ Synopsis
#/    Create cd aliases for each subdirectory of a dir.
######################################################################
p6_alias_cd_dirs() {
    local dir="$1" # directory path

    #    p6_alias__debug "cd_dirs(): $dir"

    if p6_dir_exists "$dir"; then
        local d
        for d in $(p6_dirs_list "$dir"); do
            p6_alias "$cd$d" "cd $dir/$d"
        done
    else
        p6_alias__debug "cd_dirs(): $dir DNE"
    fi

    p6_return_void
}

# XXX: rename p6_alias_create
######################################################################
#<
#
# Function: p6_alias(from, to)
#
#  Args:
#	from - alias name
#	to - alias expansion
#
#>
#/ Synopsis
#/    Define a shell alias from one name to another command.
######################################################################
p6_alias() {
    local from="$1" # alias name
    local to="$2"   # alias expansion

    p6_alias__debug "alias(): $from -> $to"

    if ! p6_string_blank "$to"; then
        if ! p6_string_blank "$from"; then
            alias $from="$to"
        fi
    fi
    p6_return_void
}
