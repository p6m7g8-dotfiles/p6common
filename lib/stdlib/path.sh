# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_path__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for PATH helpers.
######################################################################
p6_path__debug() {
    local msg="$1" # debug message

    p6_debug "p6_path: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: true  = p6_path_if(dir, [where=append])
#
#  Args:
#	dir - directory path
#	OPTIONAL where - append or prepend [append]
#
#  Returns:
#	true - 
#	false - 
#
#  Environment:	 PATH
#>
#/ Synopsis
#/    Add a directory to PATH when it exists.
######################################################################
p6_path_if() {
    local dir=$1          # directory path
    local where="${2:-append}" # append or prepend

    if p6_dir_exists "$dir"; then
      if p6_string_eq "$where" "prepend"; then
        PATH=$(p6_string_prepend "$PATH" "$dir" ":")
      else
        PATH=$(p6_string_append "$PATH" "$dir" ":")
      fi
      p6_path__debug "if(): $dir appended to PATH "
      p6_return_true
    else
      p6_path__debug "if(): $dir DNE, NOT appended to PATH"
      p6_return_false
    fi
}

######################################################################
#<
#
# Function: p6_path_default()
#
#  Environment:	 HOME PATH
#>
#/ Synopsis
#/    Reset PATH to a standard set of directories.
######################################################################
p6_path_default() {

    p6_path__debug "default(): unset"

    PATH=
    path_if $HOME/bin
    path_if /opt/X11/bin
    path_if /usr/local/bin
    path_if /usr/local/sbin
    path_if /usr/bin
    path_if /usr/sbin
    path_if /bin
    path_if /sbin

    p6_path__debug "default(): $PATH"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_path_current()
#
#  Environment:	 PATH
#>
#/ Synopsis
#/    Print the current PATH entries vertically.
######################################################################
p6_path_current() {

    p6_vertical "$PATH"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cdpath_current()
#
#  Environment:	 CDPATH
#>
#/ Synopsis
#/    Print the current CDPATH entries vertically.
######################################################################
p6_cdpath_current() {

    p6_vertical "$CDPATH"

    p6_return_void
}
