# shellcheck shell=bash

######################################################################
#<
#
# Function: code  = p6_return_true()
#
#  Returns:
#	code - 
#
#  Environment:	 P6_TRUE
#>
#/ Synopsis
#/    Suitable for use in conditionals
#/
######################################################################
p6_return_true() {

    p6_return_code_as_code $P6_TRUE
}

######################################################################
#<
#
# Function: code  = p6_return_false()
#
#  Returns:
#	code - 
#
#  Environment:	 P6_FALSE
#>
#/ Synopsis
#/    Suitable for use in conditionals
#/
######################################################################
p6_return_false() {

    p6_return_code_as_code $P6_FALSE
}

######################################################################
#<
#
# Function: p6_return_void()
#
#>
#/ Synopsis
#/    The literal absence of a return value
#/    Do not use this in conditionals
#/    Do not use this in blank string checks
#/    Use me when the function simply groups commands for re-use
#/
######################################################################
p6_return_void() {

    return
}

######################################################################
#<
#
# Function: code bool = p6_return_bool(bool)
#
#  Args:
#	bool -
#
#  Returns:
#	code - bool
#
#  Environment:	 P6_EXIT_ARGS
#>
#/ Synopsis
#/    Exactly 0 or 1
#/    No blanks
#/    Suitable for use in conditionals
#/
######################################################################
p6_return_bool() {
    local bool="$1"

    case $bool in
    0 | 1) ;;
    *) p6_die "$P6_EXIT_ARGS" "[$bool] is neither 0|1" ;;
    esac

    if [ -z "$bool" ]; then
        p6_error "bool is blank"
    fi

    p6_return_code_as_code "$bool"
}

######################################################################
#<
#
# Function: p6_return_size_t(size_t)
#
#  Args:
#	size_t -
#
#  Environment:	 P6_EXIT_ARGS
#>
#/ Synopsis
#/    Any Positive Integer
#/    No blanks
#/
######################################################################
p6_return_size_t() {
    local size_t="$1"

    case $size_t in
    [0-9]*) ;;
    *) p6_die "$P6_EXIT_ARGS" "size_t is not a number" ;;
    esac

    if [ $size_t -lt 0 ]; then
        p6_die "$P6_EXIT_ARGS" "[$size_t] is not a positive number"
    fi

    p6_return "$size_t"
}

######################################################################
#<
#
# Function: p6_return_int(int)
#
#  Args:
#	int -
#
#  Environment:	 P6_EXIT_ARGS
#>
#/ Synopsis
#/    Any Integer Positive or Negative
#/
######################################################################
p6_return_int() {
    local int="$1"

    case $int in
    -[0-9]*) ;;
    [0-9]*) ;;
    *) p6_die "$P6_EXIT_ARGS" "[$int] is not a number" ;;
    esac

    p6_return "$int"
}

######################################################################
#<
#
# Function: p6_return_float(float)
#
#  Args:
#	float -
#
#  Environment:	 P6_EXIT_ARGS
#>
#/ Synopsis
#/    Any floating point
#/    No blanks
#/
######################################################################
p6_return_float() {
    local float="$1"

    case $float in
    *.*) ;;
    *) p6_die "$P6_EXIT_ARGS" "[$float] is not a float" ;;
    esac

    p6_return "$float"
}

######################################################################
#<
#
# Function: code rc = p6_return_filter(rc)
#
#  Args:
#	rc -
#
#  Returns:
#	code - rc
#
#>
#/ Synopsis
#/  Filters return this for syntaxtic sugar
#/  Maintains the filters $? rc code for pipe chain short circuits
#/
######################################################################
p6_return_filter() {
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: p6_return_ipv4(ip)
#
#  Args:
#	ip -
#
#  Environment:	 EOF IFS P6_EXIT_ARGS _IFS
#>
#/ Synopsis
#/  Any IP v4 address
#/
######################################################################
p6_return_ipv4() {
    local ip="$1"

    local valid=false
    if p6_echo "$ip" | grep -qE '^([0-9]{1,3}\.){3}[0-9]{1,3}$'; then
        local octet1
        local octet2
        local octet3
        local octet4
        local old_IFS=$IFS
        IFS='.' read -r octet1 octet2 octet3 octet4 <<EOF
$ip
EOF
        IFS=$old_IFS

        local octet
        for octet in $octet1 $octet2 $octet3 $octet4; do
            if [ "$octet" -gt 255 ] || [ "$octet" -lt 0 ]; then
                valid=false
                break
            fi
        done
        valid=true
    fi

    if p6_string_eq "$valid" "false"; then
        p6_die "$P6_EXIT_ARGS" "[$ip] is not an IPv4"
    fi

    p6_return "$ip"
}

######################################################################
#<
#
# Function: true  = p6_return_stream()
#
#  Returns:
#	true - 
#
#>
#/ Synopsis
#/  Function emits arbitrary text
#/
######################################################################
p6_return_stream() {

    p6_return_true
}

######################################################################
#<
#
# Function: p6_return_str(str)
#
#  Args:
#	str -
#
#>
#/ Synopsis
#/    Any string
#/    BLANKS allowed
#/
######################################################################
p6_return_str() {
    local str="$1"

    p6_return "$str"
}

######################################################################
#<
#
# Function: p6_return_path(path)
#
#  Args:
#	path -
#
#  Environment:	 P6_EXIT_ARGS
#>
#/ Synopsis
#/    Specialized string of well formed simple unix paths
#/    Only /, letters, numbers, -, _, @, +, ~, ., ','
#/    NO SPACES, QUOTES etc...
#/
######################################################################
p6_return_path() {
    local path="$1"

    case $path in
    [a-zA-Z0-9/-_@+~.,][a-zA-Z0-9/-_@+~.,]*) ;;
    *) p6_die "$P6_EXIT_ARGS" "[$path] is not a path" ;;
    esac

    p6_return "$path"
}

######################################################################
#<
#
# Function: p6_return_date(date)
#
#  Args:
#	date -
#
#  Environment:	 ISO ISO8601 P6_EXIT_ARGS
#>
#/ Synopsis
#/  Only the listed dates are allowed
#/  Think twice before adding more
#/
######################################################################
p6_return_date() {
    local date="$1"

    case $date in
    [0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]T[0-2][0-9]:[0-5][0-9]:[0-5][0-9]) ;; # Full ISO8601 with time  # %Y-%m-%dT%H:%M:%S
    [0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]) ;;                                  # ISO8601 date            # %Y-%m-%d
    [0-1][0-9]/[0-3][0-9]/[0-9][0-9][0-9][0-9]) ;;                                  # US date                 # %m/%d/%Y
    [0-1][0-9]/[0-3][0-9]/[0-9][0-9]) ;;                                            # US short                # %m/%d/%y
    [0-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]) ;;                                    # Numeric date            # %Y%m%d
    "[0-1][0-9]/[0-3][0-9]/[0-9][0-9][0-9][0-9] [0-2][0-9]:[0-5][0-9]") ;;          # US format               # %m/%d/%Y %H:%M
    [0-9][0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9]) ;;                                  # ISO week date           # %Y-W%V-%u
    [0-2][0-9]:[0-5][0-9]:[0-5][0-9]) ;;                                            # Time                    # %H:%M:%S
    [0-1][0-9]/[0-9][0-9][0-9][0-9]) ;;                                             # Month and year          # %m/%y
    [1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]) ;;                          # epoch seconds           # %s
    *) p6_die "$P6_EXIT_ARGS" "[$date] is not a date" ;;
    esac

    p6_return "$date"
}

######################################################################
#<
#
# Function: p6_return_words(words)
#
#  Args:
#	words -
#
#>
#/ Synopsis
#/    A word is a loop item. Words is a collection of words.
#/    Words should be split on $IFS
#/    "" or '' count as a blank word
#/
######################################################################
p6_return_words() {
    local words="$@"

    p6_return "$words"
}

######################################################################
#<
#
# Function: code rc = p6_return_code_as_code(rc)
#
#  Args:
#	rc -
#
#  Returns:
#	code - rc
#
#>
######################################################################
p6_return_code_as_code() {
    local rc="$1"

    p6_return_code__validate "$rc"

    return $rc
}

######################################################################
#<
#
# Function: code rc = p6_return_code_as_value(rc)
#
#  Args:
#	rc -
#
#  Returns:
#	code - rc
#
#>
######################################################################
p6_return_code_as_value() {
    local rc="$1"

    p6_return_code__validate "$rc"

    p6_echo "$rc"
}

######################################################################
#<
#
# Function: true  = p6_return(rv)
#
#  Args:
#	rv -
#
#  Returns:
#	true - 
#
#>
######################################################################
p6_return() {
    local rv="$1"

    p6_echo "$rv"

    p6_return_true
}

#
# Private
#
######################################################################
#<
#
# Function: p6_return_code__validate(rc)
#
#  Args:
#	rc -
#
#  Environment:	 P6_EXIT_ARGS
#>
######################################################################
p6_return_code__validate() {
    local rc="$rc"

    if [ -z "$rc" ]; then
        p6_error "p6_return: code(): rc is blank, caller is wrong"
    fi

    case $rc in
    [0-9]*) ;;
    *)
        p6_error "$P6_EXIT_ARGS" "[$rc] is not a number"
        p6_return_void
        ;;
    esac

    if [ $rc -lt 0 -o $rc -gt 255 ]; then
        p6_die "$P6_EXIT_ARGS" "[$rc] is < 0 or > 255"
    fi

    p6_return_void
}
