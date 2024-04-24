# shellcheck shell=bash

######################################################################
#<
#
# Function: code rc = p6_math_lt()
#
#  Returns:
#	code - rc
#
#>
######################################################################
p6_math_lt() {
    local a="$1"
    local b="$2"

    test $a -lt $b
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: code rc = p6_math_lte(a, b)
#
#  Args:
#	a -
#	b -
#
#  Returns:
#	code - rc
#
#>
######################################################################
p6_math_lte() {
    local a="$1"
    local b="$2"

    test $a -le $b
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: code rc = p6_math_gt(a, b)
#
#  Args:
#	a -
#	b -
#
#  Returns:
#	code - rc
#
#>
######################################################################
p6_math_gt() {
    local a="$1"
    local b="$2"

    test $a -gt $b
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: code rc = p6_math_gte(a, b)
#
#  Args:
#	a -
#	b -
#
#  Returns:
#	code - rc
#
#>
######################################################################
p6_math_gte() {
    local a="$1"
    local b="$2"

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
#	a -
#	b -
#
#  Returns:
#	int - rv
#
#>
######################################################################
p6_math_sub() {
    local a="$1"
    local b="$2"

    local rv=$(($a - $b))

    p6_return_int "$rv"
}

######################################################################
#<
#
# Function: int result = p6_math_inc(a, [b=1])
#
#  Args:
#	a -
#	OPTIONAL b - [1]
#
#  Returns:
#	int - result
#
#>
######################################################################
p6_math_inc() {
    local a="$1"
    local b="${2:-1}"

    local result=$(($a + $b))

    p6_return_int "$result"
}

######################################################################
#<
#
# Function: int result = p6_math_dec(a, [b=1])
#
#  Args:
#	a -
#	OPTIONAL b - [1]
#
#  Returns:
#	int - result
#
#>
######################################################################
p6_math_dec() {
    local a="$1"
    local b="${2:-1}"

    local result=$(($a - $b))

    p6_return_int "$result"
}

######################################################################
#<
#
# Function: int result = p6_math_multiply(a, b)
#
#  Args:
#	a -
#	b -
#
#  Returns:
#	int - result
#
#>
######################################################################
p6_math_multiply() {
    local a="$1"
    local b="$2"

    local result=$(($a * $b))

    p6_return_int "$result"
}
