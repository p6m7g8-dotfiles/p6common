# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_string__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for string helpers.
######################################################################
p6_string__debug() {
    local msg="$1" # debug message

    p6_debug "p6_string: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: bool rv = p6_string_blank(str)
#
#  Args:
#	str - string to test
#
#  Returns:
#	bool - rv
#
#>
#/ Synopsis
#/    Return true when the string is empty.
######################################################################
p6_string_blank() {
    local str="$1" # string to test

    test -z "$str"
    local rv=$?

    p6_string__debug "blank(): [$str] -> $rv"

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: bool rv = p6_string_blank_NOT(str)
#
#  Args:
#	str - string to test
#
#  Returns:
#	bool - rv
#
#>
#/ Synopsis
#/    Return true when the string is not empty.
######################################################################
p6_string_blank_NOT() {
    local str="$1" # string to test

    test -n "$str"
    local rv=$?

    p6_string__debug "blank_NOT(): [$str] -> $rv"

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: bool rv = p6_string_eq(str, val)
#
#  Args:
#	str - left-hand string
#	val - right-hand string
#
#  Returns:
#	bool - rv
#
#>
#/ Synopsis
#/    Return true when two strings are equal.
######################################################################
p6_string_eq() {
    local str="$1" # left-hand string
    local val="$2" # right-hand string

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
# Function: bool rv = p6_string_ne(str, val)
#
#  Args:
#	str - left-hand string
#	val - right-hand string
#
#  Returns:
#	bool - rv
#
#>
#/ Synopsis
#/    Return true when two strings are different.
######################################################################
p6_string_ne() {
    local str="$1" # left-hand string
    local val="$2" # right-hand string

    local rv
    if p6_string_eq "$str" "$val"; then
        rv=$P6_FALSE
    else
        rv=$P6_TRUE
    fi

    p6_string__debug "ne(): [$str] ne? [$val] -> $rv"

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: bool rc = p6_string_eq_1(str)
#
#  Args:
#	str - string to test
#
#  Returns:
#	bool - rc
#
#>
#/ Synopsis
#/    Return true when the string equals 1.
######################################################################
p6_string_eq_1() {
    local str="$1" # string to test

    p6_string_eq "$str" "1"
    local rc=$?
    p6_string__debug "eq_1(): [$str] eq? [1] -> $rc"

    p6_return_bool "$rc"
}

######################################################################
#<
#
# Function: bool rc = p6_string_eq_0(str)
#
#  Args:
#	str - string to test
#
#  Returns:
#	bool - rc
#
#>
#/ Synopsis
#/    Return true when the string equals 0.
######################################################################
p6_string_eq_0() {
    local str="$1" # string to test

    p6_string_eq "$str" "0"
    local rc=$?
    p6_string__debug "eq_0(): [$str] eq? [0] -> $rc"

    p6_return_bool "$rc"
}

######################################################################
#<
#
# Function: bool rc = p6_string_ne_0(str)
#
#  Args:
#	str - string to test
#
#  Returns:
#	bool - rc
#
#>
#/ Synopsis
#/    Return true when the string does not equal 0.
######################################################################
p6_string_ne_0() {
    local str="$1" # string to test

    p6_string_ne "$str" "0"
    local rc=$?
    p6_string__debug "ne_0(): [$str] ne? [0] -> $rc"

    p6_return_bool "$rc"
}

######################################################################
#<
#
# Function: bool rc = p6_string_eq_neg_1(str)
#
#  Args:
#	str - string to test
#
#  Returns:
#	bool - rc
#
#>
#/ Synopsis
#/    Return true when the string equals -1.
######################################################################
p6_string_eq_neg_1() {
    local str="$1" # string to test

    p6_string_eq "$str" "-1"
    local rc=$?
    p6_string__debug "eq_neg_1(): [$str] eq? [-1] -> $rc"

    p6_return_bool "$rc"
}

######################################################################
#<
#
# Function: bool rv = p6_string_eq_any(str, ...)
#
#  Args:
#	str - string to test
#	... - remaining values to compare
#
#  Returns:
#	bool - rv
#
#>
#/ Synopsis
#/    Return true when the string matches any of the provided values.
######################################################################
p6_string_eq_any() {
    local str="$1" # string to test
    shift 1        # remaining values to compare

    local vals="$*"
    local rv=$P6_FALSE
    local val
    for val in "$@"; do
        if p6_string_eq "$str" "$val"; then
            rv=$P6_TRUE
            break
        fi
    done

    p6_string__debug "eq_any(): [$str] in [$vals] -> $rv"

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: bool rv = p6_string_contains(str, needle)
#
#  Args:
#	str - haystack string
#	needle - substring to find
#
#  Returns:
#	bool - rv
#
#>
#/ Synopsis
#/    Return true when the string contains the needle.
######################################################################
p6_string_contains() {
    local str="$1"    # haystack string
    local needle="$2" # substring to find

    local rv=$P6_FALSE
    if ! p6_string_blank "$needle"; then
        p6_echo "$str" | grep -F -q -- "$needle"
        rv=$?
    fi

    p6_string__debug "contains(): [$str] has [$needle] -> $rv"

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: bool rv = p6_string_starts_with(str, prefix)
#
#  Args:
#	str - input string
#	prefix - prefix to match
#
#  Returns:
#	bool - rv
#
#>
#/ Synopsis
#/    Return true when the string starts with the given prefix.
######################################################################
p6_string_starts_with() {
    local str="$1"    # input string
    local prefix="$2" # prefix to match

    local rv=$P6_FALSE
    if ! p6_string_blank "$prefix"; then
        case "$str" in
        "$prefix"*) rv=$P6_TRUE ;;
        *) rv=$P6_FALSE ;;
        esac
    fi

    p6_string__debug "starts_with(): [$str] starts [$prefix] -> $rv"

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: bool rv = p6_string_ends_with(str, suffix)
#
#  Args:
#	str - input string
#	suffix - suffix to match
#
#  Returns:
#	bool - rv
#
#>
#/ Synopsis
#/    Return true when the string ends with the given suffix.
######################################################################
p6_string_ends_with() {
    local str="$1"    # input string
    local suffix="$2" # suffix to match

    local rv=$P6_FALSE
    if ! p6_string_blank "$suffix"; then
        case "$str" in
        *"$suffix") rv=$P6_TRUE ;;
        *) rv=$P6_FALSE ;;
        esac
    fi

    p6_string__debug "ends_with(): [$str] ends [$suffix] -> $rv"

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: bool rv = p6_string_match_regex(str, re)
#
#  Args:
#	str - input string
#	re - extended regex
#
#  Returns:
#	bool - rv
#
#>
#/ Synopsis
#/    Return true when the string matches the regex pattern.
######################################################################
p6_string_match_regex() {
    local str="$1" # input string
    local re="$2"  # extended regex

    local rv=$P6_FALSE
    if ! p6_string_blank "$re"; then
        p6_echo "$str" | grep -E -q -- "$re"
        rv=$?
    fi

    p6_string__debug "match_regex(): [$str] =~ [$re] -> $rv"

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: size_t len = p6_string_len(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	size_t - len
#
#>
#/ Synopsis
#/    Return the length of the string in characters.
######################################################################
p6_string_len() {
    local str="$1" # input string

    local len="${#str}"

    p6_return_size_t "$len"
}

######################################################################
#<
#
# Function: str out = p6_string_default(str, default)
#
#  Args:
#	str - input string
#	default - fallback value
#
#  Returns:
#	str - out
#
#>
#/ Synopsis
#/    Return the default when the string is blank.
######################################################################
p6_string_default() {
    local str="$1"     # input string
    local default="$2" # fallback value

    local out="$str"
    if p6_string_blank "$str"; then
        out="$default"
    fi

    p6_string__debug "default(): [$str] or [$default] -> [$out]"

    p6_return_str "$out"
}

######################################################################
#<
#
# Function: str str_a = p6_string_append(str, add, [sep= ])
#
#  Args:
#	str - base string
#	add - string to append
#	OPTIONAL sep - separator between parts [ ]
#
#  Returns:
#	str - str_a
#
#>
#/ Synopsis
#/    Append a value to a string with a separator.
######################################################################
p6_string_append() {
    local str="$1"     # base string
    local add="$2"     # string to append
    local sep="${3:- }" # separator between parts

    local str_a="${str}${sep}${add}"

    p6_string__debug "append(): [$str] + [$add] by [$sep] -> [$str_a]"

    p6_return_str "$str_a"
}

######################################################################
#<
#
# Function: str str_a = p6_string_prepend(str, add, [sep= ])
#
#  Args:
#	str - base string
#	add - string to prepend
#	OPTIONAL sep - separator between parts [ ]
#
#  Returns:
#	str - str_a
#
#>
#/ Synopsis
#/    Prepend a value to a string with a separator.
######################################################################
p6_string_prepend() {
    local str="$1"     # base string
    local add="$2"     # string to prepend
    local sep="${3:- }" # separator between parts

    local str_a="${add}${sep}${str}"

    p6_string__debug "prepend(): [$add] + [$str] by [$sep] -> [$str_a]"

    p6_return_str "$str_a"
}

######################################################################
#<
#
# Function: str str_lc = p6_string_lc(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_lc
#
#>
#/ Synopsis
#/    Lowercase a string.
######################################################################
p6_string_lc() {
    local str="$1" # input string

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
#	str - input string
#
#  Returns:
#	str - str_uc
#
#>
#/ Synopsis
#/    Uppercase a string.
######################################################################
p6_string_uc() {
    local str="$1" # input string

    local str_uc=$(p6_echo "$str" | tr '[a-z]' '[A-Z]')

    p6_string__debug "uc(): [$str] -> [$str_uc]"

    p6_return_str "$str_uc"
}

######################################################################
#<
#
# Function: str str_r = p6_string_replace(str, from, to, [flags=g])
#
#  Args:
#	str - input string
#	from - sed pattern to replace
#	to - replacement string
#	OPTIONAL flags - sed flags (default: global) [g]
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Replace pattern matches with a replacement string.
######################################################################
p6_string_replace() {
    local str="$1"       # input string
    local from="$2"      # sed pattern to replace
    local to="$3"        # replacement string
    local flags="${4:-g}" # sed flags (default: global)

    local str_r=$(p6_echo "$str" | sed -e "s,$from,$to,$flags")

    p6_string__debug "replace([$from]->[$to],$flags): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_strip_prefix(str, prefix)
#
#  Args:
#	str - input string
#	prefix - prefix to remove
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Remove a prefix when present.
######################################################################
p6_string_strip_prefix() {
    local str="$1"    # input string
    local prefix="$2" # prefix to remove

    local str_r="$str"
    case "$str_r" in
    "$prefix"*) str_r="${str_r#"$prefix"}" ;;
    esac

    p6_string__debug "strip_prefix([$prefix]): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_strip_suffix(str, suffix)
#
#  Args:
#	str - input string
#	suffix - suffix to remove
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Remove a suffix when present.
######################################################################
p6_string_strip_suffix() {
    local str="$1"    # input string
    local suffix="$2" # suffix to remove

    local str_r="$str"
    case "$str_r" in
    *"$suffix") str_r="${str_r%"$suffix"}" ;;
    esac

    p6_string__debug "strip_suffix([$suffix]): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_strip_single_quote(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Remove single quotes from a string.
######################################################################
p6_string_strip_single_quote() {
    local str="$1" # input string

    local str_r="${str//\'/}"

    p6_string__debug "strip_single_quote(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_strip_double_quote(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Remove double quotes from a string.
######################################################################
p6_string_strip_double_quote() {
    local str="$1" # input string

    local str_r="${str//\"/}"

    p6_string__debug "strip_double_quote(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_strip_quotes(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Remove both single and double quotes from a string.
######################################################################
p6_string_strip_quotes() {
    local str="$1" # input string

    local str_r="${str//\"/}"
    str_r="${str_r//\'/}"

    p6_string__debug "strip_quotes(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_strip_chars(str, chars)
#
#  Args:
#	str - input string
#	chars - character class to remove
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Remove all occurrences of the given character set.
######################################################################
p6_string_strip_chars() {
    local str="$1"   # input string
    local chars="$2" # character class to remove

    local str_r=$(p6_echo "$str" | sed -e "s/[${chars}]//g")

    p6_string__debug "strip_chars([$chars]): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_strip_leading_spaces(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Strip leading spaces from a string.
######################################################################
p6_string_strip_leading_spaces() {
    local str="$1" # input string

    local str_r="$str"
    str_r=${str_r#"${str_r%%[! ]*}"}

    p6_string__debug "strip_leading_spaces(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_strip_trailing_spaces(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Strip trailing spaces from a string.
######################################################################
p6_string_strip_trailing_spaces() {
    local str="$1" # input string

    local str_r="$str"
    str_r=${str_r%"${str_r##*[! ]}"}

    p6_string__debug "strip_trailing_spaces(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_strip_leading_and_trailing_spaces(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Strip both leading and trailing spaces from a string.
######################################################################
p6_string_strip_leading_and_trailing_spaces() {
    local str="$1" # input string

    local str_r
    str_r=$(p6_string_strip_trailing_spaces "$str")
    str_r=$(p6_string_strip_leading_spaces "$str_r")

    p6_string__debug "strip_leading_and_trailing_spaces(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_strip_spaces(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Remove all spaces from a string.
######################################################################
p6_string_strip_spaces() {
    local str="$1" # input string

    local str_r
    str_r=$(p6_string_replace "$str" " " "")

    p6_string__debug "strip_spaces(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_strip_alum(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Remove all alphanumeric characters from a string.
######################################################################
p6_string_strip_alum() {
    local str="$1" # input string

    local str_r=$(p6_echo "$str" | sed -e 's,[a-zA-Z0-9],,g')

    p6_string__debug "strip_alum(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_strip_alum_and_underscore(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Remove alphanumerics and underscores from a string.
######################################################################
p6_string_strip_alum_and_underscore() {
    local str="$1" # input string

    local str_r=$(p6_echo "$str" | sed -e 's,[a-zA-Z0-9_],,g')

    p6_string__debug "strip_alum_and_underscore(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_strip_trailing_slash(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Strip a trailing slash from a path-like string.
######################################################################
p6_string_strip_trailing_slash() {
    local str="$1" # input string

    local str_r
    str_r=$(p6_string_strip_suffix "$str" "/")

    p6_string__debug "strip_trailing_slash(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_nodeenv_to_nodenv(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Rewrite nodeenv to nodenv within a string.
######################################################################
p6_string_nodeenv_to_nodenv() {
    local str="$1" # input string

    local str_r="${str//nodeenv/nodenv}"

    p6_string__debug "nodeenv_to_nodenv(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_sanitize_dot_id(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Normalize a dotted identifier by replacing :/.- with underscores.
######################################################################
p6_string_sanitize_dot_id() {
    local str="$1" # input string

    local str_r=$(p6_echo "$str" | tr ':/.-' '_')

    p6_string__debug "sanitize_dot_id(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_sanitize_identifier(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Convert non-identifier characters to underscores.
######################################################################
p6_string_sanitize_identifier() {
    local str="$1" # input string

    local str_r=$(p6_echo "$str" | sed -e 's,[^A-Za-z0-9_],_,g')

    p6_string__debug "sanitize_identifier(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_strip_non_branch_chars(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Remove characters not allowed in branch identifiers.
######################################################################
p6_string_strip_non_branch_chars() {
    local str="$1" # input string

    local str_r=$(p6_echo "$str" | sed -e 's,[^A-Za-z0-9_#],,g')

    p6_string__debug "strip_non_branch_chars(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_strip_brackets(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Remove literal square brackets from a string.
######################################################################
p6_string_strip_brackets() {
    local str="$1" # input string

    local str_r="${str//\[/}"
    str_r="${str_r//\]/}"

    p6_string__debug "strip_brackets(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_slash_to_underscore(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Replace slashes with underscores.
######################################################################
p6_string_slash_to_underscore() {
    local str="$1" # input string

    local str_r="${str//\//_}"

    p6_string__debug "slash_to_underscore(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_r = p6_string_collapse_double_slash(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_r
#
#>
#/ Synopsis
#/    Collapse repeated slashes to single slashes.
######################################################################
p6_string_collapse_double_slash() {
    local str="$1" # input string

    local str_r=$(p6_echo "$str" | sed -e 's,//,/,g')

    p6_string__debug "collapse_double_slash(): [$str] -> [$str_r]"

    p6_return_str "$str_r"
}

######################################################################
#<
#
# Function: str str_ic = p6_string_init_cap(str)
#
#  Args:
#	str - input string
#
#  Returns:
#	str - str_ic
#
#>
#/ Synopsis
#/    Capitalize the first letter of each word.
######################################################################
p6_string_init_cap() {
    local str="$1" # input string

    local str_ic=$(
        p6_echo "$str" |
            awk '{for(i=1;i<=NF;i++){ $i=toupper(substr($i,1,1)) substr($i,2) }}1'
    )

    p6_return_str "$str_ic"
}

######################################################################
#<
#
# Function: str padded = p6_string_zero_pad(str, pad)
#
#  Args:
#	str - numeric string
#	pad - width to pad to
#
#  Returns:
#	str - padded
#
#>
#/ Synopsis
#/    Zero-pad a number to a fixed width.
######################################################################
p6_string_zero_pad() {
    local str="$1" # numeric string
    local pad="$2" # width to pad to

    local padded=$(printf "%0${pad}d" $str)

    p6_return_str "$padded"
}
