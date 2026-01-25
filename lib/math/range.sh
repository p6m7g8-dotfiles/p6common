# shellcheck shell=bash

######################################################################
#<
#
# Function: words elements = p6_math_range_generate(begin, end)
#
#  Args:
#	begin - range start
#	end - range end
#
#  Returns:
#	words - elements
#
#>
#/ Synopsis
#/    Generates an inclusive numeric range from begin to end.
######################################################################
p6_math_range_generate() {
    local begin="$1" # range start
    local end="$2"   # range end

    local elements=$(seq "$begin" "$end")

    p6_return_words "$elements"
}
