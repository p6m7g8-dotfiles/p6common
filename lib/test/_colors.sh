# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_test_colorize_plan()
#
#>
######################################################################
p6_test_colorize_plan() {
    local line="$1"

    p6_test_colorize__say "blue" "black" "$line"
}

######################################################################
#<
#
# Function: p6_test_colorize_not_ok(line)
#
#  Args:
#	line -
#
#>
######################################################################
p6_test_colorize_not_ok() {
    local line="$1"

    p6_test_colorize__say "red" "black" "$line"
}

######################################################################
#<
#
# Function: p6_test_colorize_ok(line)
#
#  Args:
#	line -
#
#>
######################################################################
p6_test_colorize_ok() {
    local line="$1"

    p6_test_colorize__say "green" "black" "$line"
}

######################################################################
#<
#
# Function: p6_test_colorize_skip(line)
#
#  Args:
#	line -
#
#>
######################################################################
p6_test_colorize_skip() {
    local line="$1"

    p6_test_colorize__say "magenta" "black" "$line"
}

######################################################################
#<
#
# Function: p6_test_colorize_todo(line)
#
#  Args:
#	line -
#
#>
######################################################################
p6_test_colorize_todo() {
    local line="$1"

    p6_test_colorize__say "yellow" "black" "$line"
}

######################################################################
#<
#
# Function: p6_test_colorize_diagnostic(line)
#
#  Args:
#	line -
#
#>
######################################################################
p6_test_colorize_diagnostic() {
    local line="$1"

    p6_test_colorize__say "white" "black" "$line"
}

######################################################################
#<
#
# Function: p6_test_colorize_block(line)
#
#  Args:
#	line -
#
#>
######################################################################
p6_test_colorize_block() {
    local line="$1"

    p6_test_colorize__say "black" "white" "$line"
}

######################################################################
#<
#
# Function: p6_test_colorize_bail(line)
#
#  Args:
#	line -
#
#>
######################################################################
p6_test_colorize_bail() {
    local line="$1"

    p6_test_colorize__say "cyan" "black" "$line"
}

######################################################################
#<
#
# Function: p6_test_colorize__say(color_fg, color_bg, msg)
#
#  Args:
#	color_fg -
#	color_bg -
#	msg -
#
#  Environment:	 P6_TEST_COLOR_OFF
#>
######################################################################
p6_test_colorize__say() {
    local color_fg="$1"
    local color_bg="$2"
    local msg="$3"

    local code_fg=$(p6_test_colorize__color_to_code "$color_fg")
    local code_bg=$(p6_test_colorize__color_to_code "$color_bg")

    if [ -z "$P6_TEST_COLOR_OFF" ]; then
       tput setaf "$code_fg"
       tput setab "$code_bg"
    fi
    echo "$msg"
    if [ -z "$P6_TEST_COLOR_OFF" ]; then
       tput sgr0
    fi
    echo
}

######################################################################
#<
#
# Function: p6_test_colorize__color_to_code(color)
#
#  Args:
#	color -
#
#>
######################################################################
p6_test_colorize__color_to_code() {
    local color="$1"

    local code

    case $color in
	black)   code=0 ;;
	red)     code=1 ;;
	green)   code=2 ;;
	yellow)  code=3 ;;
	blue)    code=4 ;;
	magenta) code=5 ;;
	cyan)    code=6 ;;
	white)   code=7 ;;
    esac

    echo $code
}
