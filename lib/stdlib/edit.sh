# shellcheck shell=bash

######################################################################
#<
#
# Function: code ? = p6_edit_editor_run()
#
#  Returns:
#	code - ?
#
#>
######################################################################
p6_edit_editor_run() {
    local editor="$1"
    local scratch_file="$2"

    p6_run_code "$editor \"$scratch_file\""

    p6_return_code_as_code "$?"
}

######################################################################
#<
#
# Function: path scratch_file = p6_edit_scratch_file_create(msg)
#
#  Args:
#	msg -
#
#  Returns:
#	path - scratch_file
#
#>
######################################################################
p6_edit_scratch_file_create() {
    local msg="$1"

    local scratch_file=$(p6_transient_create_file "scratch_file")
    p6_echo "$msg" >"$scratch_file"

    p6_return_path "$scratch_file"
}
