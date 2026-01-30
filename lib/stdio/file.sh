# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_file__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for file helpers.
######################################################################
p6_file__debug() {
    local msg="$1" # debug message

    p6_debug "p6_file: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: size_t modified_epoch_seconds = p6_file_mtime(file)
#
#  Args:
#	file - file path
#
#  Returns:
#	size_t - modified_epoch_seconds
#
#>
#/ Synopsis
#/    Return the file's modification time in epoch seconds.
######################################################################
p6_file_mtime() {
    local file="$1" # file path

    local modified_epoch_seconds=$(stat -f "%m" $file)

    p6_return_size_t "$modified_epoch_seconds"
}

######################################################################
#<
#
# Function: p6_file_load(file)
#
#  Args:
#	file - file path
#
#  Environment:	 P6_PREFIX
#>
#/ Synopsis
#/    Source a file, honoring P6_PREFIX when set.
######################################################################
p6_file_load() {
    local file="$1" # file path

    if p6_string_blank_NOT "$P6_PREFIX"; then
        case "$P6_PREFIX" in
        */) file="${P6_PREFIX}${file}" ;;
        *) file="${P6_PREFIX}/${file}" ;;
        esac
    fi

    case "$file" in
    */*) ;;
    *) file="./$file" ;;
    esac

    p6_log ". $file"
    . "$file"
    
    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_move(src, dst)
#
#  Args:
#	src - source path
#	dst - destination path
#
#>
#/ Synopsis
#/    Move or rename a file.
######################################################################
p6_file_move() {
    local src="$1" # source path
    local dst="$2" # destination path

    p6_file__debug "move(): $src $dst"
    mv $src $dst

    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_copy(src, dst)
#
#  Args:
#	src - source path
#	dst - destination path
#
#>
#/ Synopsis
#/    Copy a file.
######################################################################
p6_file_copy() {
    local src="$1" # source path
    local dst="$2" # destination path

    p6_file__debug "copy(): $src -> $dst"
    cp $src $dst

    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_rmf(file)
#
#  Args:
#	file - file path
#
#>
#/ Synopsis
#/    Remove a file if it exists.
######################################################################
p6_file_rmf() {
    local file="$1" # file path

    p6_file__debug "rmf(): rm -f $file"
    rm -f $file

    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_unlink(file)
#
#  Args:
#	file - file path
#
#>
#/ Synopsis
#/    Unlink a file.
######################################################################
p6_file_unlink() {
    local file="$1" # file path

    p6_file__debug "unlink(): unlink $file"
    unlink $file

    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_contains(pattern, file)
#
#  Args:
#	pattern - grep pattern
#	file - file path
#
#>
#/ Synopsis
#/    Select lines from a file matching a pattern.
######################################################################
p6_file_contains() {
    local pattern="$1" # grep pattern
    local file="$2"    # file path

    p6_file__debug "contains(): /$pattern/ $file"
    p6_file_display "$file" | p6_filter_row_select "$pattern"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_line_delete_last(file)
#
#  Args:
#	file - file path
#
#>
#/ Synopsis
#/    Delete the last line of a file in place.
######################################################################
p6_file_line_delete_last() {
    local file="$1" # file path

    p6_file__debug "line_delete_last(): sed -i '' -e '$d' $file"
    sed -i '' -e '$d' $file

    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_replace(file, sed_cmd, file, sed_cmd)
#
#  Args:
#	file - file path
#	sed_cmd - sed expression
#	file - file path
#	sed_cmd - sed expression
#
#>
#/ Synopsis
#/    Run a sed expression in-place on a file.
######################################################################
p6_file_replace() {
    local file="$1"    # file path
    local sed_cmd="$2" # sed expression

    p6_file__debug "replace(): sed -i '' -e $sed_cmd $file"
    sed -i '' -e $sed_cmd $file

    p6_return_void
}

######################################################################
#<
#
# Function: bool rv = p6_file_exists(file)
#
#  Args:
#	file - file path
#
#  Returns:
#	bool - rv
#
#>
#/ Synopsis
#/    Return true when a file is readable.
######################################################################
p6_file_exists() {
    local file="$1" # file path

    test -r "$file"
    local rv=$?

    p6_file__debug "exists(): $file -> $rv"

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: bool rv = p6_file_exists_NOT(file)
#
#  Args:
#	file - file path
#
#  Returns:
#	bool - rv
#
#>
#/ Synopsis
#/    Return true when a file is NOT readable (inverse of p6_file_exists).
######################################################################
p6_file_exists_NOT() {
    local file="$1" # file path

    test ! -r "$file"
    local rv=$?

    p6_file__debug "exists_NOT(): $file -> $rv"

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: bool rv = p6_file_executable(file)
#
#  Args:
#	file - file path
#
#  Returns:
#	bool - rv
#
#>
#/ Synopsis
#/    Return true when a file is executable.
######################################################################
p6_file_executable() {
    local file="$1" # file path

    test -x "$file"
    local rv=$?

    p6_file__debug "executable(): $file -> $rv"

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: p6_file_display(file)
#
#  Args:
#	file - file path
#
#>
#/ Synopsis
#/    Output the contents of a file if it exists.
######################################################################
p6_file_display() {
    local file="$1" # file path

    p6_file__debug "display(): cat $file"
    if p6_file_exists "$file"; then
        cat $file
    fi

    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_create(file)
#
#  Args:
#	file - file path
#
#>
#/ Synopsis
#/    Create an empty file.
######################################################################
p6_file_create() {
    local file="$1" # file path

    p6_file__debug "create(): touch $file"
    touch $file

    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_write(file, contents)
#
#  Args:
#	file - file path
#	contents - content to write
#
#>
#/ Synopsis
#/    Overwrite a file with the given contents.
######################################################################
p6_file_write() {
    local file="$1"     # file path
    local contents="$2" # content to write

    p6_file__debug "write(): $contents -> $file"
    p6_echo "$contents" >$file

    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_append(file, contents)
#
#  Args:
#	file - file path
#	contents - content to append
#
#>
#/ Synopsis
#/    Append contents to a file.
######################################################################
p6_file_append() {
    local file="$1"     # file path
    local contents="$2" # content to append

    p6_file__debug "append(): $contents -> $file"
    p6_echo "$contents" >>$file

    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_ma_sync(from, to)
#
#  Args:
#	from - source file
#	to - target file
#
#>
#/ Synopsis
#/    Sync modification time from one file to another.
######################################################################
p6_file_ma_sync() {
    local from="$1" # source file
    local to="$2"   # target file

    p6_file__debug "ma_sync(): $from -> $to"
    touch -r $from $to

    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_symlink(to, from)
#
#  Args:
#	to - link target
#	from - link path
#
#>
#/ Synopsis
#/    Create a symbolic link.
######################################################################
p6_file_symlink() {
    local to="$1"   # link target
    local from="$2" # link path

    p6_file__debug "symlink(): $to -> $from"
    ln -s $to $from

    p6_return_void
}

######################################################################
#<
#
# Function: path path/$cmd = p6_file_cascade(cmd, exts, ...)
#
#  Args:
#	cmd - command name
#	exts - extension list
#	... - search paths
#
#  Returns:
#	path - path/$cmd
#	path - path/$cmd$ext
#
#>
#/ Synopsis
#/    Search paths for a command, optionally with extensions.
######################################################################
p6_file_cascade() {
    local cmd="$1"  # command name
    local exts="$2" # extension list
    shift 2         # search paths

    # Search
    local path
    for path in "$@"; do
        if p6_string_blank_NOT "${exts}"; then
            p6_file__debug "cascade(): Checking: $path/$cmd"
            if p6_file_exists "$path/$cmd"; then
                p6_file__debug "cascade(): Found: $path/$cmd"
                p6_return_path "$path/$cmd"
            fi
        else
            local ext
            for ext in $exts ''; do
                p6_file__debug "cascade(): [$ext] Checking: $path/$cmd$ext"
                if p6_file_exists "$path/$cmd$ext"; then
                    p6_file__debug "cascade(): [$ext] Found: $path/$cmd$ext"
                    p6_return_path "$path/$cmd$ext"
                fi
            done
        fi
    done
}

######################################################################
#<
#
# Function: str line = p6_file_line_first(file)
#
#  Args:
#	file - file path
#
#  Returns:
#	str - line
#
#>
#/ Synopsis
#/    Return the first line of a file.
######################################################################
p6_file_line_first() {
    local file="$1" # file path

    local line=$(p6_filter_row_first "1" <"$file")

    p6_return_str "$line"
}

######################################################################
#<
#
# Function: str lines = p6_file_lines_last(file, n)
#
#  Args:
#	file - file path
#	n - number of lines
#
#  Returns:
#	str - lines
#
#>
#/ Synopsis
#/    Return the last N lines of a file.
######################################################################
p6_file_lines_last() {
    local file="$1" # file path
    local n="$2"    # number of lines

    local lines=$(p6_filter_row_last "$n" <"$file")

    p6_return_str "$lines"
}

######################################################################
#<
#
# Function: int count = p6_file_lines(file)
#
#  Args:
#	file - file path
#
#  Returns:
#	int - count
#
#>
#/ Synopsis
#/    Count the number of lines in a file.
######################################################################
p6_file_lines() {
    local file="$1" # file path

    local count=$(p6_filter_rows_count <"$file" | p6_filter_strip_leading_and_trailing_spaces)

    p6_return_int "$count"
}

######################################################################
#<
#
# Function: str lines = p6_file_lines_except_first(file)
#
#  Args:
#	file - file path
#
#  Returns:
#	str - lines
#
#>
#/ Synopsis
#/    Return all lines except the first.
######################################################################
p6_file_lines_except_first() {
    local file="$1" # file path

    local c=$(p6_file_lines "$file")
    local l=$(p6_math_sub "$c" "1")

    local lines=$(p6_file_lines_last "$file" "$l")

    p6_return_str "$lines"
}

######################################################################
#<
#
# Function: str lines = p6_file_lines_first(file, n)
#
#  Args:
#	file - file path
#	n - number of lines
#
#  Returns:
#	str - lines
#
#>
#/ Synopsis
#/    Return the first N lines of a file.
######################################################################
p6_file_lines_first() {
    local file="$1" # file path
    local n="$2"    # number of lines

    local lines=$(p6_filter_row_first "$n" <"$file")

    p6_return_str "$lines"
}

######################################################################
#<
#
# Function: p6_file_replace(file, sed_cmd, file, sed_cmd)
#
#  Args:
#	file - file path
#	sed_cmd - sed expression
#	file - file path
#	sed_cmd - sed expression
#
#>
#/ Synopsis
#/    Run a sed expression in-place on a file.
######################################################################
p6_file_replace() {
    local file="$1"    # file path
    local sed_cmd="$2" # sed expression

    sed -i '' -e "$sed_cmd" "$file"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_marker_delete_to_end(file, marker)
#
#  Args:
#	file - file path
#	marker - marker pattern
#
#>
#/ Synopsis
#/    Delete from the marker line to the end of the file.
######################################################################
p6_file_marker_delete_to_end() {
    local file="$1"   # file path
    local marker="$2" # marker pattern

    p6_file_replace "$file" "/^$marker/,\$d"

    p6_return_void
}
