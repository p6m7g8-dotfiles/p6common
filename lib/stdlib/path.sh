# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_path__debug()
#
#>
######################################################################
p6_path__debug() {
    local msg="$1"

    p6_debug "p6_path: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: true  = p6_path_if(dir, [where=append])
#
#  Args:
#	dir -
#	OPTIONAL where - [append]
#
#  Returns:
#	true - 
#	false - 
#
#  Environment:	 PATH
#>
######################################################################
p6_path_if() {
    local dir=$1
    local where="${2:-append}"

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
######################################################################
p6_cdpath_current() {

    p6_vertical "$CDPATH"

    p6_return_void
}
