######################################################################
#<
#
# Function: p6_unroll_functions()
#
#>
#/ Synopsis
#/    Writes unrolled function definitions into fpath/ for each p6 function.
######################################################################
p6_unroll_functions() {

    local function
    for function in $(grep -R ^p6 lib | p6_filter_column_pluck 2 ":" | p6_filter_extract_before "("); do
        p6_unroll_function "$function" >fpath/$function
    done
}

######################################################################
#<
#
# Function: str s/p6_return_str/echo/g = p6_unroll_filter()
#
#  Returns:
#	str - s/p6_return_str/echo/g
#	float - s/p6_return_float/echo/g
#	size_t - s/p6_return_size_t/echo/g
#	bool - s/p6_return_bool/return/g
#	filter - 
#
#>
#/ Synopsis
#/    Rewrites p6 return helpers into plain shell equivalents for filters.
######################################################################
p6_unroll_filter() {

    sed -e 's/p6_return_str/echo/g' \
        -e 's/p6_return_float/echo/g' \
        -e 's/p6_return_size_t/echo/g' \
        -e 's/p6_return_void/return/g' \
        -e 's/p6_return_bool/return/g' \
        -e 's/p6_return_code_as_code/return/g' \
        -e 's/p6_file_load/./g' \
        -e 's/p6_msg/echo/g'

    p6_return_filter
}

######################################################################
#<
#
# Function: p6_unroll_function(function)
#
#  Args:
#	function - function name
#
#>
#/ Synopsis
#/    Emits the shell source of a function, optionally filtered for unrolling.
######################################################################
p6_unroll_function() {
    local function="$1" # function name

    local filter=0
    if p6_string_eq_1 "$filter"; then
        case $function in
        *debug*) return ;;
        *p6_return*) return ;;
        esac
        which $function | \
            p6_unroll_filter | \
            p6_filter_row_exclude "p6_alias__debug" | \
            p6_filter_row_exclude "p6_cicd__debug" | \
            p6_filter_row_exclude "p6_time"
    else
        which $function
    fi
}
