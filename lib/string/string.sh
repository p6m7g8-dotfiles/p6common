# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_string__debug()
#
#>
######################################################################
p6_string__debug() {
    local msg="$1"

    p6_debug "p6_string: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: bool rv = p6_string_blank(str)
#
#  Args:
#	str -
#
#  Returns:
#	bool - rv
#
#>
######################################################################
p6_string_blank() {
    local str="$1"

    test -z "$str"
    local rv=$?

    p6_string__debug "blank(): [$str] -> $rv"

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: bool rv = p6_string_eq(str, val)
#
#  Args:
#	str -
#	val -
#
#  Returns:
#	bool - rv
#
#  Environment:	 P6_FALSE P6_TRUE
#>
######################################################################
p6_string_eq() {
    local str="$1"
    local val="$2"

    local rv
    if [ x"$str" = x"$val" ]; then
        rv=$P6_TRUE
    else
        rv=$P6_FALSE
    fi

    p6_string__debug "eq(): [$str] eq? [$val] -> $rv"

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: bool rv = p6_string_eq_1(str)
#
#  Args:
#	str -
#
#  Returns:
#	bool - rv
#
#>
######################################################################
p6_string_eq_1() {
    local str="$1"

    local rv
    rv=$(p6_string_eq "$str" "1")

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: size_t len = p6_string_len(str)
#
#  Args:
#	str -
#
#  Returns:
#	size_t - len
#
#>
######################################################################
p6_string_len() {
    local str="$1"

    local len="${#str}"

    p6_return_size_t "$len"
}

######################################################################
#<
#
# Function: str str_a = p6_string_append(str, add, [sep= ])
#
#  Args:
#	str -
#	add -
#	OPTIONAL sep - [ ]
#
#  Returns:
#	str - str_a
#
#>
######################################################################
p6_string_append() {
    local str="$1"
    local add="$2"
    local sep="${3:- }"

    local str_a="${str}${sep}${add}"

    p6_string__debug "append(): [$str] + [$add] by [$sep] -> [$str_a]"

    p6_return_str "$str_a"
}

######################################################################
#<
#
# Function: str str_lc = p6_string_lc(str)
#
#  Args:
#	str -
#
#  Returns:
#	str - str_lc
#
#>
######################################################################
p6_string_lc() {
    local str="$1"

    local str_lc=$(p6_echo "$str" | tr '[A-Z]' '[a-z]')

    p6_string__debug "lc(): [$str] -> [$str_lc]"

    p6_return_str "$str_lc"
}

######################################################################
#<
#
# Function: str str_uc = p6_string_uc(str)
#
#  Args:
#	str -
#
#  Returns:
#	str - str_uc
#
#>
######################################################################
p6_string_uc() {
    local str="$1"

    local str_uc=$(p6_echo "$str" | tr '[a-z]' '[A-Z]')

    p6_string__debug "uc(): [$str] -> [$str_lc]"

    p6_return_str "$str_uc"
}

######################################################################
#<
#
# Function: str str_r = p6_string_replace(str, from, to)
#
#  Args:
#	str -
#	from -
#	to -
#
#  Returns:
#	str - str_r
#
#>
######################################################################
p6_string_replace() {
    local str="$1"
    local from="$2"
    local to="$3"

    local str_r=$(p6_echo "$str" | sed -e "s,$from,$to,g")

    p6_string__debug "replace([$from]->[$to]): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_ic = p6_string_init_cap(str)
#
#  Args:
#	str -
#
#  Returns:
#	str - str_ic
#
#>
######################################################################
p6_string_init_cap() {
    local str="$1"

    local str_ic=$(
        p6_echo "$str" |
            awk '{for(i=1;i<=NF;i++){ $i=toupper(substr($i,1,1)) substr($i,2) }}1'
    )

    p6_return_str "$str_ic"
}
