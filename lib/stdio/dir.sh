# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_dir__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for dir helpers.
######################################################################
p6_dir__debug() {
    local msg="$1" # debug message

    p6_debug "p6_dir: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_dir_load(dirs)
#
#  Args:
#	dirs - directory list
#
#>
#/ Synopsis
#/    Load files from each directory in the list.
######################################################################
p6_dir_load() {
    local dirs="$@" # directory list

    p6_dir__debug "load(): $dirs"

    local dir
    for dir in $dirs; do
        local children=$(p6_dirs_list $dirs)
        for child in $(p6_echo "$children"); do
            p6_file_load "$dir/$child"
        done
    done

    p6_return_void
}

######################################################################
#<
#
# Function: words children = p6_dir_list(dir)
#
#  Args:
#	dir - directory path
#
#  Returns:
#	words - children
#
#>
#/ Synopsis
#/    List entries in a directory.
######################################################################
p6_dir_list() {
    local dir="$1" # directory path

    local children
    if p6_dir_exists "$dir"; then
        children=$(p6_run_dir "$dir" "ls -1 | xargs")
        p6_dir__debug "list(): collected [$dir] -> [$children]"
    else
        p6_dir__debug "list(): [$dir] DNE"
    fi

    p6_return_words "$children"
}

######################################################################
#<
#
# Function: words entries = p6_dirs_list(dirs)
#
#  Args:
#	dirs - directory list
#
#  Returns:
#	words - entries
#
#>
#/ Synopsis
#/    List entries across multiple directories.
######################################################################
p6_dirs_list() {
    local dirs="$@" # directory list

    p6_dir__debug "list(): $dirs"

    local entries=""
    local dir
    for dir in $dirs; do
        local children=""
        children=$(p6_dir_list "$dir")
        if p6_string_blank_NOT "$children"; then
            entries=$(p6_string_append "$entries" "$children" " ")
        fi
    done

    p6_return_words "$entries"
}

######################################################################
#<
#
# Function: words descendants = p6_dir_list_recursive(dir)
#
#  Args:
#	dir - directory path
#
#  Returns:
#	words - descendants
#
#>
#/ Synopsis
#/    List files recursively under a directory.
######################################################################
p6_dir_list_recursive() {
    local dir="$1" # directory path

    p6_dir__debug "list_recursive(): $dir"

    local descendants=$(
        find $dir \
            -type f |
            xargs
    )

    p6_dir__debug "list_recursive(): $descendants"

    p6_return_words "$descendants"
}

######################################################################
#<
#
# Function: p6_dir_exists(dir)
#
#  Args:
#	dir - directory path
#
#>
#/ Synopsis
#/    Return success when a directory exists.
######################################################################
p6_dir_exists() {
    local dir="$1" # directory path

    test -d "$dir"
    local rc=$?

    p6_dir__debug "exists(): [dir=$dir] -> [rc=$rc]"

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: bool rv = p6_dir_exists_NOT(dir)
#
#  Args:
#	dir - directory path
#
#  Returns:
#	bool - rv
#
#>
#/ Synopsis
#/    Return success when a directory does NOT exist (inverse of p6_dir_exists).
######################################################################
p6_dir_exists_NOT() {
    local dir="$1" # directory path

    test ! -d "$dir"
    local rc=$?

    p6_dir__debug "exists_NOT(): [dir=$dir] -> [rc=$rc]"

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: p6_dir_rmrf(dir)
#
#  Args:
#	dir - directory path
#
#>
#/ Synopsis
#/    Remove a directory tree with safety checks.
######################################################################
p6_dir_rmrf() {
    local dir="$1" # directory path

    if p6_string_blank "$dir" || p6_string_eq "$dir" "/"; then
        p6_msg "p6_dir: rmrf(): Cowardly refusing to shoot us in the foot [$dir]"
    else
        p6_dir__debug "rmrf(): rm -rf $dir"
        rm -rf $dir
    fi

    p6_return_void
}

######################################################################
#<
#
# Function: p6_dir_mk(dir)
#
#  Args:
#	dir - directory path
#
#>
#/ Synopsis
#/    Create a directory if it does not exist.
######################################################################
p6_dir_mk() {
    local dir="$1" # directory path

    if p6_dir_exists_NOT "$dir"; then
        p6_dir__debug "mk(): mkdir -p $dir"
        mkdir -p $dir
    fi

    p6_return_void
}

######################################################################
#<
#
# Function: p6_dir_cp(src, dst)
#
#  Args:
#	src - source directory
#	dst - destination directory
#
#>
#/ Synopsis
#/    Copy a directory recursively.
######################################################################
p6_dir_cp() {
    local src="$1" # source directory
    local dst="$2" # destination directory

    p6_dir__debug "cp(): cp -R $src $dst"
    cp -R $src $dst

    p6_return_void
}

######################################################################
#<
#
# Function: p6_dir_mv(src, dst)
#
#  Args:
#	src - source directory
#	dst - destination directory
#
#>
#/ Synopsis
#/    Move or rename a directory.
######################################################################
p6_dir_mv() {
    local src="$1" # source directory
    local dst="$2" # destination directory

    p6_dir__debug "mv(): mv $src $dst"
    mv $src $dst

    p6_return_void
}

######################################################################
#<
#
# Function: p6_dir_cd(dir)
#
#  Args:
#	dir - directory path
#
#>
#/ Synopsis
#/    Change to a directory with logging.
######################################################################
p6_dir_cd() {
    local dir="$1" # directory path

    p6_dir__debug "cd(): cd $dir"
    p6_log "cd $dir"
    cd $dir

    p6_return_void
}

######################################################################
#<
#
# Function: p6_dir_replace_in(dir, from, to)
#
#  Args:
#	dir - directory root (unused in current implementation)
#	from - pattern to replace
#	to - replacement text
#
#>
#/ Synopsis
#/    Replace text in files under a directory tree.
######################################################################
p6_dir_replace_in() {
  local dir="$1"  # directory root (unused in current implementation)
  local from="$2" # pattern to replace
  local to="$3"   # replacement text

  find . -type f |
    p6_filter_row_exclude_regex '/.git/|/elpa/' |
    xargs grep -l $from |
    xargs perl -pi -e "s,$from,$to,g"

  p6_return_void
}
