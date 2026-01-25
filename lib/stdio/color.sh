# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_color__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for color helpers.
######################################################################
p6_color__debug() {
    local msg="$1" # debug message

    p6_debug "p6_color: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_color_ize(color_fg, color_bg, msg)
#
#  Args:
#	color_fg - foreground color name
#	color_bg - background color name
#	msg - message text
#
#  Environment:	 P6_TEST_COLOR_OFF
#>
#/ Synopsis
#/    Print a message with foreground/background colors (no newline).
######################################################################
p6_color_ize() {
    local color_fg="$1" # foreground color name
    local color_bg="$2" # background color name
    local msg="$3"      # message text

    local code_fg=$(p6_color_to_code "$color_fg")
    local code_bg=$(p6_color_to_code "$color_bg")

    if p6_string_blank "$P6_TEST_COLOR_OFF"; then
        tput setaf "$code_fg"
        tput setab "$code_bg"
    fi

    p6_msg "$msg\c"

    if p6_string_blank "$P6_TEST_COLOR_OFF"; then
        tput sgr0
    fi

    p6_return_void
}

######################################################################
#<
#
# Function: p6_color_say(color_fg, color_bg, msg)
#
#  Args:
#	color_fg - foreground color name
#	color_bg - background color name
#	msg - message text
#
#>
#/ Synopsis
#/    Print a message with foreground/background colors and newline.
######################################################################
p6_color_say() {
    local color_fg="$1" # foreground color name
    local color_bg="$2" # background color name
    local msg="$3"      # message text

    p6_color_ize "$color_fg" "$color_bg" "$msg"
    p6_msg

    p6_return_void
}

######################################################################
#<
#
# Function: size_t code = p6_color_to_code(color)
#
#  Args:
#	color - color name
#
#  Returns:
#	size_t - code
#
#>
#/ Synopsis
#/    Convert a color name to a tput color code.
######################################################################
p6_color_to_code() {
    local color="$1" # color name

    local code=-1

    case $color in
    black) code=0 ;;
    red) code=1 ;;
    green) code=2 ;;
    yellow) code=3 ;;
    blue) code=4 ;;
    magenta) code=5 ;;
    cyan) code=6 ;;
    white) code=7 ;;
    esac

    p6_color__debug "say(): [$color] -> [$code]"

    p6_return_size_t "$code"
}

######################################################################
#<
#
# Function: float 0.0 = p6_color_opacity_factor()
#
#  Returns:
#	float - 0.0
#
#>
#/ Synopsis
#/    Return the default opacity factor.
######################################################################
p6_color_opacity_factor() {

    p6_return_float "0.0"
}

######################################################################
#<
#
# Function: str rgb = p6_color_name_to_rgb(name)
#
#  Args:
#	name - color name
#
#  Returns:
#	str - rgb
#
#>
#/ Synopsis
#/    Convert a color name to a hex RGB string.
######################################################################
p6_color_name_to_rgb() {
    local name="$1" # color name

    local rgb=-1
    case $name in
    red) rgb="fa053e" ;;
    orange) rgb="fa6b05" ;;
    yellow) rgb="dedb86" ;;
    green) rgb="1c6928" ;;
    dgreen) rgb="064a10" ;;
    cyan) rgb="3beaf6" ;;
    blue) rgb="054cf2" ;;
    dblue) rgb="1a2261" ;;
    lpurple) rgb="eb5bd5" ;;
    purple) rgb="973bcc" ;;
    pink) rgb="f213d5" ;;
    lsalmon3) rgb="cd8162" ;;
    brown) rgb="542323" ;;
    black) rgb="000000" ;;
    white) rgb="ffffff" ;;
    esac

    rgb=$(p6_string_uc "$rgb")

    p6_return_str "$rgb"
}

######################################################################
#<
#
# Function: str dr = p6_color_hex_to_d16b(hex, ord)
#
#  Args:
#	hex - hex RGB string
#	ord - channel selector (r/g/b)
#
#  Returns:
#	str - dr
#	str - dg
#	str - db
#
#>
#/ Synopsis
#/    Convert hex RGB to a 16-bit channel value.
######################################################################
p6_color_hex_to_d16b() {
    local hex="$1" # hex RGB string
    local ord="$2" # channel selector (r/g/b)

    local i=$(p6_echo "$hex" | p6_filter_translate_hex_pairs_to_csv | p6_filter_column_pluck 1 ",")
    local j=$(p6_echo "$hex" | p6_filter_translate_hex_pairs_to_csv | p6_filter_column_pluck 2 ",")
    local k=$(p6_echo "$hex" | p6_filter_translate_hex_pairs_to_csv | p6_filter_column_pluck 3 ",")

    local r=$(p6_color_hext_to_rgb "$i")
    local g=$(p6_color_hext_to_rgb "$j")
    local b=$(p6_color_hext_to_rgb "$k")

    if p6_string_blank "$r"; then
        r=0
    fi

    if p6_string_blank "$g"; then
        g=0
    fi

    if p6_string_blank "$b"; then
        b=0
    fi

    local dr=$(p6_math_multiply "$r" "257")
    local dg=$(p6_math_multiply "$g" "257")
    local db=$(p6_math_multiply "$b" "257")

    p6_color__debug "hex_to_d16b(): [hex=$hex] [ord=$ord] -> [dr=$dr] [dg=$dg] [db=$db]"

    case $ord in
    r) p6_return_str "$dr" ;;
    g) p6_return_str "$dg" ;;
    b) p6_return_str "$db" ;;
    *) p6_error "no such channel" ;;
    esac
}

######################################################################
#<
#
# Function: size_t channel = p6_color_hext_to_rgb(h)
#
#  Args:
#	h - hex byte
#
#  Returns:
#	size_t - channel
#
#>
#/ Synopsis
#/    Convert a hex byte to a numeric channel value.
######################################################################
p6_color_hext_to_rgb() {
    local h="$1" # hex byte

    local channel=$((16#$(printf "%s\n" $h)))

    p6_return_size_t "$channel"
}
