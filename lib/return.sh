######################################################################
#<
#
# Function:
#	code  = p6_return_true()
#
#  Returns:
#	code - 
#
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
# Function:
#	code  = p6_return_false()
#
#  Returns:
#	code - 
#
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
# Function:
#	p6_return_void()
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
# Function:
#	code bool = p6_return_bool(bool)
#
#  Args:
#	bool - 
#
#  Returns:
#	code - bool
#
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
	0|1) ;;
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
# Function:
#	p6_return_size_t(size_t)
#
#  Args:
#	size_t - 
#
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

    p6_return__ "$size_t"
}

######################################################################
#<
#
# Function:
#	p6_return_int(int)
#
#  Args:
#	int - 
#
#>
#/ Synopsis
#/    Any Positive Integer
#/    No blanks
#/
######################################################################
p6_return_int() {
    local int="$1"

    case $int in
	[0-9]*) ;;
	*) p6_die "$P6_EXIT_ARGS" "[$int] is not a number" ;;
    esac

    p6_return__ "$int"
}

######################################################################
#<
#
# Function:
#	p6_return_float(float)
#
#  Args:
#	float - 
#
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

    p6_return__ "$float"
}

######################################################################
#<
#
# Function:
#	p6_return_str(str)
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

    p6_return__ "$str"
}

######################################################################
#<
#
# Function:
#	p6_return_path(path)
#
#  Args:
#	path - 
#
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

    p6_return__ "$path"
}

######################################################################
#<
#
# Function:
#	p6_return_words(words)
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

    p6_return__ "$words"
}

p6_return_code_as_code() {
    local rc="$1"

    p6_return_code__validate "$rc"

    return $rc
}

p6_return_code_as_value() {
    local rc="$1"

    p6_return_code__validate "$rc"

    p6_echo "$rc"
}

#
# Private
#
######################################################################
#<
#
# Function:
#	code P6_RETURN_SUCCESS = p6_return__(rv)
#
#  Args:
#	rv -
#
#  Returns:
#	code - P6_RETURN_SUCCESS
#
#>
######################################################################
p6_return__() {
    local rv="$1"

    p6_echo "$rv"
}

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

######################################################################
#<
#
# Function:
#	code P6_RETURN_SUCCESS = p6_return(rv)
#
#  Args:
#	rv - 
#
#  Returns:
#	code - P6_RETURN_SUCCESS
#
#>
######################################################################
p6_return() {
    local rv="$1"

    p6__deprecated "p6_return()"

    p6_echo "$rc"

    p6_return_true
}
