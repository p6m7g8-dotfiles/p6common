# shellcheck shell=bash

######################################################################
#<
#
# Function: words elements = p6_math_range_generate()
#
#  Returns:
#	words - elements
#
#>
######################################################################
p6_math_range_generate() {
    local begin="$1"
    local end="$2"

    local elements=$(seq "$begin" "$end")

    p6_return_words "$elements"
}
