# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_echo()
#
#>
######################################################################
p6_echo() {

    echo "$@"
}

######################################################################
#<
#
# Function: p6_msg(msg)
#
#  Args:
#	msg -
#
#>
######################################################################
p6_msg() {
    local msg="$*"

    p6_echo "$msg"
}

######################################################################
#<
#
# Function: p6_msg_no_nl(msg)
#
#  Args:
#	msg -
#
#>
######################################################################
p6_msg_no_nl() {
    local msg="$*"

    p6_echo -n "$msg"
}

######################################################################
#<
#
# Function: p6_msg_h3()
#
#>
######################################################################
p6_msg_h3() {

    p6_h3 "$*"
}

######################################################################
#<
#
# Function: p6_msg_success()
#
#>
#/ Synopsis
#/  Outputs [CHECK] followed by message
#/
######################################################################
p6_msg_success() {

    echo "✅: $*"
}

######################################################################
#<
#
# Function: p6_msg_fail()
#
#>
#/ Synopsis
#/  Outputs [FAIL] followed by message
#/
######################################################################
p6_msg_fail() {

    echo "❌: $*"
}

######################################################################
#<
#
# Function: p6_error(msg)
#
#  Args:
#	msg -
#
#>
######################################################################
p6_error() {
    local msg="$*"

    p6_msg "$msg" >&2
}

######################################################################
#<
#
# Function: $code  = p6_die(code)
#
#  Args:
#	code -
#
#  Returns:
#	$code - 
#
#>
######################################################################
p6_die() {
    local code="$1"
    shift

    p6_msg "$@"
    exit $code
}

######################################################################
#<
#
# Function: p6__header(indent)
#
#  Args:
#	indent -
#
#>
######################################################################
p6__header() {
    local indent="$1"
    shift

    local h=""
    local i=0
    while [ $i -lt $indent ]; do
        h="${h}="
        i=$(($i + 1))
    done

    p6_msg "$h> $@"

    p6_return_void
}

######################################################################
#<
#
# Function: p6__deprecated(thing)
#
#  Args:
#	thing -
#
#  Environment:	 DEPRECATED
#>
######################################################################
p6__deprecated() {
    local thing="$1"

    p6_msg "DEPRECATED: $thing"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_h1(header)
#
#  Args:
#	header -
#
#>
######################################################################
p6_h1() {
    local header="$1"

    p6__header "2" "$header"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_h2(header)
#
#  Args:
#	header -
#
#>
######################################################################
p6_h2() {
    local header="$1"

    p6__header "4" "$header"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_h3(header)
#
#  Args:
#	header -
#
#>
######################################################################
p6_h3() {
    local header="$1"

    p6__header "6" "$header"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_h4(header)
#
#  Args:
#	header -
#
#>
######################################################################
p6_h4() {
    local header="$1"

    p6__header "8" "$header"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_h5(header)
#
#  Args:
#	header -
#
#>
######################################################################
p6_h5() {
    local header="$1"

    p6__header "10" "$header"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_h6(header)
#
#  Args:
#	header -
#
#>
######################################################################
p6_h6() {
    local header="$1"

    p6__header "12" "$header"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_vertical(v)
#
#  Args:
#	v -
#
#  Environment:	 IFS IFS_SAVED
#>
######################################################################
p6_vertical() {
    local v="$1"

    local IFS_SAVED=$IFS
    local i

    IFS=:
    for i in $(echo $v); do
        p6_echo "$i"
    done
    IFS=$IFS_SAVED

    p6_return_void
}
