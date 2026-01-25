# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_edit_editor_run(editor, scratch_file)
#
#  Args:
#	editor - editor command
#	scratch_file - file to edit
#
#>
#/ Synopsis
#/    Run an editor command on a scratch file.
######################################################################
p6_edit_editor_run() {
    local editor="$1"       # editor command
    local scratch_file="$2" # file to edit

    p6_run_code "$editor \"$scratch_file\""

    p6_return_code_as_code "$?"
}

######################################################################
#<
#
# Function: path scratch_file = p6_edit_scratch_file_create(msg)
#
#  Args:
#	msg - initial contents
#
#  Returns:
#	path - scratch_file
#
#>
#/ Synopsis
#/    Create a scratch file prefilled with a message.
######################################################################
p6_edit_scratch_file_create() {
    local msg="$1" # initial contents

    local scratch_file=$(p6_transient_create_file "scratch_file")
    p6_echo "$msg" >"$scratch_file"

    p6_return_path "$scratch_file"
}
