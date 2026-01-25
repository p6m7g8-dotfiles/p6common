# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_echo()
#
#>
#/ Synopsis
#/    Echo arguments to stdout.
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
#	msg - message text
#
#>
#/ Synopsis
#/    Print a message with a trailing newline.
######################################################################
p6_msg() {
    local msg="$*" # message text

    p6_echo "$msg"
}

######################################################################
#<
#
# Function: p6_msg_no_nl(msg)
#
#  Args:
#	msg - message text
#
#>
#/ Synopsis
#/    Print a message without a trailing newline.
######################################################################
p6_msg_no_nl() {
    local msg="$*" # message text

    p6_echo -n "$msg"
}

######################################################################
#<
#
# Function: p6_msg_h3()
#
#>
#/ Synopsis
#/    Print a level-3 header message.
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
#/    Print a success message with a checkmark prefix.
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
#/    Print a failure message with a cross prefix.
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
#	msg - message text
#
#>
#/ Synopsis
#/    Print an error message to stderr.
######################################################################
p6_error() {
    local msg="$*" # message text

    p6_msg "$msg" >&2
}

######################################################################
#<
#
# Function: p6_die(code, ...)
#
#  Args:
#	code - exit code
#	... - message text
#
#>
#/ Synopsis
#/    Print a message and exit with the given code.
######################################################################
p6_die() {
    local code="$1" # exit code
    shift           # message text

    p6_msg "$@"
    exit $code
}

######################################################################
#<
#
# Function: p6__header(indent, ...)
#
#  Args:
#	indent - number of '=' characters
#	... - header text
#
#>
#/ Synopsis
#/    Print a header line prefixed by a repeated '=' marker.
######################################################################
p6__header() {
    local indent="$1" # number of '=' characters
    shift             # header text

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
#	thing - deprecated feature name
#
#>
#/ Synopsis
#/    Print a DEPRECATED warning for a feature.
######################################################################
p6__deprecated() {
    local thing="$1" # deprecated feature name

    p6_msg "DEPRECATED: $thing"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_h1(header)
#
#  Args:
#	header - header text
#
#>
#/ Synopsis
#/    Print a level-1 header.
######################################################################
p6_h1() {
    local header="$1" # header text

    p6__header "2" "$header"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_h2(header)
#
#  Args:
#	header - header text
#
#>
#/ Synopsis
#/    Print a level-2 header.
######################################################################
p6_h2() {
    local header="$1" # header text

    p6__header "4" "$header"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_h3(header)
#
#  Args:
#	header - header text
#
#>
#/ Synopsis
#/    Print a level-3 header.
######################################################################
p6_h3() {
    local header="$1" # header text

    p6__header "6" "$header"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_h4(header)
#
#  Args:
#	header - header text
#
#>
#/ Synopsis
#/    Print a level-4 header.
######################################################################
p6_h4() {
    local header="$1" # header text

    p6__header "8" "$header"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_h5(header)
#
#  Args:
#	header - header text
#
#>
#/ Synopsis
#/    Print a level-5 header.
######################################################################
p6_h5() {
    local header="$1" # header text

    p6__header "10" "$header"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_h6(header)
#
#  Args:
#	header - header text
#
#>
#/ Synopsis
#/    Print a level-6 header.
######################################################################
p6_h6() {
    local header="$1" # header text

    p6__header "12" "$header"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_vertical(v)
#
#  Args:
#	v - colon-delimited string
#
#  Environment:	 IFS IFS_SAVED
#>
#/ Synopsis
#/    Print a colon-delimited string vertically, one per line.
######################################################################
p6_vertical() {
    local v="$1" # colon-delimited string

    local IFS_SAVED=$IFS
    local i

    IFS=:
    for i in $(echo $v); do
        p6_echo "$i"
    done
    IFS=$IFS_SAVED

    p6_return_void
}
