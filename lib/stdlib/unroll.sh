######################################################################
#<
#
# Function: p6_unroll_functions()
#
#>
######################################################################
p6_unroll_functions() {

    local function
    for function in $(grep -R ^p6 lib | cut -f 2 -d : | sed -e 's,(.*,,'); do
        p6_unroll_function "$function" >fpath/$function
    done
}

######################################################################
#<
#
# Function: p6_unroll_function(function)
#
#  Args:
#	function -
#
#>
######################################################################
p6_unroll_function() {
    local function="$1"

    local filter=0
    if [ x"$filter" = x"1" ]; then
        case $function in
        *debug*) return ;;
        *p6_return*) return ;;
        esac
        which $function | sed \
            -e 's,p6_return_str,echo,g' \
            -e 's,p6_return_float,echo,g' \
            -e 's,p6_return_size_t,echo,g' \
            -e 's,p6_return_void,return,g' \
            -e 's,p6_return_bool,return,g' \
            -e 's,p6_return_code_as_code,return,g' \
            -e 's,p6_file_load,\.,g' \
            -e 's,p6_msg,echo,g' \
            -e '/p6_alias__debug/d' \
            -e '/p6_cicd__debug/d' \
            -e '/p6_time/d'
    else
        which $function
    fi
}
