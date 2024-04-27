# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_file__debug()
#
#>
######################################################################
p6_file__debug() {
    local msg="$1"

    p6_debug "p6_file: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: size_t modified_epoch_seconds = p6_file_mtime(file)
#
#  Args:
#	file -
#
#  Returns:
#	size_t - modified_epoch_seconds
#
#>
######################################################################
p6_file_mtime() {
    local file="$1"

    local modified_epoch_seconds=$(stat -f "%m" $file)

    p6_return_size_t "$modified_epoch_seconds"
}

######################################################################
#<
#
# Function: p6_file_load(file)
#
#  Args:
#	file -
#
#  Environment:	 P6_PREFIX
#>
######################################################################
p6_file_load() {
    local file="$1"

    file="$P6_PREFIX$file"
    . $file
    p6_return_void

    #    if p6_file_exists "$file"; then
    # p6_file__debug "load(): $file"
    #    fi

}

######################################################################
#<
#
# Function: p6_file_move(src, dst)
#
#  Args:
#	src -
#	dst -
#
#>
######################################################################
p6_file_move() {
    local src="$1"
    local dst="$2"

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
#	src -
#	dst -
#
#>
######################################################################
p6_file_copy() {
    local src="$1"
    local dst="$2"

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
#	file -
#
#>
######################################################################
p6_file_rmf() {
    local file="$1"

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
#	file -
#
#>
######################################################################
p6_file_unlink() {
    local file="$1"

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
#	pattern -
#	file -
#
#>
######################################################################
p6_file_contains() {
    local pattern="$1"
    local file="$2"

    p6_file__debug "contains(): /$pattern/ $file"
    grep "$pattern" $file

    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_line_delete_last(file)
#
#  Args:
#	file -
#
#>
######################################################################
p6_file_line_delete_last() {
    local file="$1"

    p6_file__debug "line_delete_last(): sed -i '' -e '$d' $file"
    sed -i '' -e '$d' $file

    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_repalce(file, sed_cmd)
#
#  Args:
#	file -
#	sed_cmd -
#
#>
######################################################################
p6_file_repalce() {
    local file="$1"
    local sed_cmd="$2"

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
#	file -
#
#  Returns:
#	bool - rv
#
#>
######################################################################
p6_file_exists() {
    local file="$1"

    test -r "$file"
    local rv=$?

    p6_file__debug "exists(): $file -> $rv"

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: bool rv = p6_file_executable(file)
#
#  Args:
#	file -
#
#  Returns:
#	bool - rv
#
#>
######################################################################
p6_file_executable() {
    local file="$1"

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
#	file -
#
#>
######################################################################
p6_file_display() {
    local file="$1"

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
#	file -
#
#>
######################################################################
p6_file_create() {
    local file="$1"

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
#	file -
#	contents -
#
#>
######################################################################
p6_file_write() {
    local file="$1"
    local contents="$2"

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
#	file -
#	contents -
#
#>
######################################################################
p6_file_append() {
    local file="$1"
    local contents="$2"

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
#	from -
#	to -
#
#>
######################################################################
p6_file_ma_sync() {
    local from="$1"
    local to="$2"

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
#	to -
#	from -
#
#>
######################################################################
p6_file_symlink() {
    local to="$1"
    local from="$2"

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
#	cmd -
#	exts -
#	... - 
#
#  Returns:
#	path - path/$cmd
#	path - path/$cmd$ext
#
#>
######################################################################
p6_file_cascade() {
    local cmd="$1"
    local exts="$2"
    shift 2

    # Search
    local path
    for path in "$@"; do
        if ! p6_string_blank "${exts}"; then
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
#	file -
#
#  Returns:
#	str - line
#
#>
######################################################################
p6_file_line_first() {
    local file="$1"

    local line=$(p6_filter_row_first "1" <"$file")

    p6_return_str "$line"
}

######################################################################
#<
#
# Function: str lines = p6_file_lines_last(file, n)
#
#  Args:
#	file -
#	n -
#
#  Returns:
#	str - lines
#
#>
######################################################################
p6_file_lines_last() {
    local file="$1"
    local n="$2"

    local lines=$(p6_filter_row_last "$n" <"$file")

    p6_return_str "$lines"
}

######################################################################
#<
#
# Function: int count = p6_file_lines(file)
#
#  Args:
#	file -
#
#  Returns:
#	int - count
#
#>
######################################################################
p6_file_lines() {
    local file="$1"

    local count=$(p6_filter_rows_count <"$file" | p6_filter_leading_and_trailing_spaces_strip)

    p6_return_int "$count"
}

######################################################################
#<
#
# Function: str lines = p6_file_lines_except_first(file)
#
#  Args:
#	file -
#
#  Returns:
#	str - lines
#
#>
######################################################################
p6_file_lines_except_first() {
    local file="$1"

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
#	file -
#	n -
#
#  Returns:
#	str - lines
#
#>
######################################################################
p6_file_lines_first() {
    local file="$1"
    local n="$2"

    local lines=$(p6_filter_row_first "$n" <"$file")

    p6_return_str "$lines"
}

######################################################################
#<
#
# Function: p6_file_replace(file, sed_cmd)
#
#  Args:
#	file -
#	sed_cmd -
#
#>
######################################################################
p6_file_replace() {
    local file="$1"
    local sed_cmd="$2"

    sed -i '' -e "$sed_cmd" "$file"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_file_marker_delete_to_end(file, marker)
#
#  Args:
#	file -
#	marker -
#
#>
######################################################################
p6_file_marker_delete_to_end() {
    local file="$1"
    local marker="$2"

    p6_file_repalce "$file" "/^$marker/,\$d"

    p6_return_void
}
