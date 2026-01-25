# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_math_lt(a, b)
#
#  Args:
#	a - left operand
#	b - right operand
#
#>
#/ Synopsis
#/    Returns true when a is less than b.
######################################################################
p6_math_lt() {
    local a="$1" # left operand
    local b="$2" # right operand

    test $a -lt $b
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: p6_math_lte(a, b)
#
#  Args:
#	a - left operand
#	b - right operand
#
#>
#/ Synopsis
#/    Returns true when a is less than or equal to b.
######################################################################
p6_math_lte() {
    local a="$1" # left operand
    local b="$2" # right operand

    test $a -le $b
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: p6_math_gt(a, b)
#
#  Args:
#	a - left operand
#	b - right operand
#
#>
#/ Synopsis
#/    Returns true when a is greater than b.
######################################################################
p6_math_gt() {
    local a="$1" # left operand
    local b="$2" # right operand

    test $a -gt $b
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: p6_math_gte(a, b)
#
#  Args:
#	a - left operand
#	b - right operand
#
#>
#/ Synopsis
#/    Returns true when a is greater than or equal to b.
######################################################################
p6_math_gte() {
    local a="$1" # left operand
    local b="$2" # right operand

    test $a -ge $b
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: int rv = p6_math_sub(a, b)
#
#  Args:
#	a - minuend
#	b - subtrahend
#
#  Returns:
#	int - rv
#
#>
#/ Synopsis
#/    Subtracts b from a and returns the integer result.
######################################################################
p6_math_sub() {
    local a="$1" # minuend
    local b="$2" # subtrahend

    local rv=$(($a - $b))

    p6_return_int "$rv"
}

######################################################################
#<
#
# Function: int result = p6_math_inc(a, [b=1])
#
#  Args:
#	a - base value
#	OPTIONAL b - increment [1]
#
#  Returns:
#	int - result
#
#>
#/ Synopsis
#/    Adds b to a (default 1) and returns the integer result.
######################################################################
p6_math_inc() {
    local a="$1"      # base value
    local b="${2:-1}" # increment

    local result=$(($a + $b))

    p6_return_int "$result"
}

######################################################################
#<
#
# Function: int result = p6_math_dec(a, [b=1])
#
#  Args:
#	a - base value
#	OPTIONAL b - decrement [1]
#
#  Returns:
#	int - result
#
#>
#/ Synopsis
#/    Subtracts b from a (default 1) and returns the integer result.
######################################################################
p6_math_dec() {
    local a="$1"      # base value
    local b="${2:-1}" # decrement

    local result=$(($a - $b))

    p6_return_int "$result"
}

######################################################################
#<
#
# Function: int result = p6_math_multiply(a, b)
#
#  Args:
#	a - left operand
#	b - right operand
#
#  Returns:
#	int - result
#
#>
#/ Synopsis
#/    Multiplies a by b and returns the integer result.
######################################################################
p6_math_multiply() {
    local a="$1" # left operand
    local b="$2" # right operand

    local result=$(($a * $b))

    p6_return_int "$result"
}
