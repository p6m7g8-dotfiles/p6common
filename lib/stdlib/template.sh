# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_template__debug()
#
#>
######################################################################
p6_template__debug() {
    local msg="$1"

    p6_debug "p6_template: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: str processed = p6_template_process(infile, ...)
#
#  Args:
#	infile -
#	... - k=v replacements
#
#  Returns:
#	str - processed
#
#>
######################################################################
p6_template_process() {
    local infile="$1"
    shift 1 # k=v replacements

    local dir=$(p6_transient_create "p6_template")
    local outfile="$dir/outfile"

    p6_file_copy "$infile" "$outfile"

    local pair
    for pair in "$@"; do
        local k=$(p6_echo "$pair" | cut -d '=' -f 1)
        local v=$(p6_echo "$pair" | cut -d '=' -f 2-)

        p6_file_replace "$outfile" "s^$k^$v^g"
    done

    local processed=$(p6_file_display "$outfile")

    p6_transient_delete "$dir"

    p6_return_str "$processed"
}
