# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_lang__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for language helpers.
######################################################################
p6_lang__debug() {
    local msg="$1" # debug message

    p6_debug "p6_langs: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: str ver = p6_lang_version(prefix)
#
#  Args:
#	prefix - language prefix (py, rb, node, etc.)
#
#  Returns:
#	str - ver
#	str - v
#
#>
#/ Synopsis
#/    Return the active version for a language prefix.
######################################################################
p6_lang_version() {
    local prefix="$1" # language prefix (py, rb, node, etc.)

    if p6_string_eq "$prefix" "py"; then
        local ver=$(uv python pin 2>/dev/null)
        p6_return_str "$ver"
    else
      local cmd="${prefix}env"
      cmd=$(p6_string_nodeenv_to_nodenv "$cmd")

      local ver

      if p6_run_code "command -v $cmd > /dev/null"; then
          ver="$(p6_run_code $cmd version-name 2>/dev/null)"

          local v
          v=$(p6_string_strip_prefix "$ver" "$prefix")
          v=$(p6_string_strip_prefix "$v" "-")

          if p6_string_eq "$v" "system"; then
              p6_lang_system_version "$prefix"
          else
              p6_return_str "$v"
          fi
      else
          p6_lang_system_version "$prefix"
      fi
  fi
}

######################################################################
#<
#
# Function: str ver = p6_lang_system_version(prefix)
#
#  Args:
#	prefix - language prefix
#
#  Returns:
#	str - ver
#	str - sys@$ver
#	str - no
#
#>
#/ Synopsis
#/    Return the system version for a language prefix.
######################################################################
p6_lang_system_version() {
    local prefix="$1" # language prefix

    local rcmd=$(p6_lang_env_2_cmd "$prefix")

    if p6_run_code "command -v $rcmd > /dev/null"; then
        local ver
        case $prefix in
        py) ver=$(uv python pin 2>/dev/null) ;;
        rb) ver=$($rcmd -v | p6_filter_column_pluck 2) ;;
        pl) ver=$($rcmd -v | p6_filter_extract_between "(" ")" | p6_filter_row_select "^v5" | p6_filter_strip_leading_v) ;;
        go) ver=$($rcmd version | p6_filter_column_pluck 3 | p6_filter_strip_leading_go) ;;
        node) ver=$($rcmd -v | p6_filter_strip_leading_v) ;;
        j) ver=$($rcmd -version 2>&1 | p6_filter_row_select "Environment" | p6_filter_extract_between "(build " ")") ;;
        jl) ver=$($rcmd -v | p6_filter_column_pluck 3) ;;
        R) ver=$($rcmd --version | p6_filter_row_select " version " | p6_filter_column_pluck 3) ;;
        scala) ver=$($rcmd -nc -version 2>&1 | p6_filter_column_pluck 5) ;;
        lua) ver=$($rcmd -v | p6_filter_column_pluck 2) ;;
        rust) ver=$($rcmd -V | p6_filter_column_pluck 2) ;;
        esac
        if p6_string_eq "rust" "$prefix"; then
            p6_return_str "$ver"
        else
            p6_return_str "sys@$ver"
        fi
    else
        p6_return_str "no"
    fi
}

######################################################################
#<
#
# Function: str prefix = p6_lang_cmd_2_env(cmd)
#
#  Args:
#	cmd - command name
#
#  Returns:
#	str - prefix
#
#>
#/ Synopsis
#/    Map a language command to its prefix.
######################################################################
p6_lang_cmd_2_env() {
    local cmd="$1" # command name

    local prefix
    case $cmd in
    python) prefix=py ;;
    ruby) prefix=rb ;;
    perl) prefix=pl ;;
    go) prefix=go ;;
    js|node) prefix=node ;;
    julia) prefix=jl ;;
    java) prefix=j ;;
    R) prefix=R ;;
    scala) prefix=scala ;;
    lua) prefix=lua ;;
    rust) prefix=rust ;;
    esac

    p6_return_str "$prefix"
}

######################################################################
#<
#
# Function: str rcmd = p6_lang_env_2_cmd(prefix)
#
#  Args:
#	prefix - language prefix
#
#  Returns:
#	str - rcmd
#
#>
#/ Synopsis
#/    Map a language prefix to its command name.
######################################################################
p6_lang_env_2_cmd() {
    local prefix="$1" # language prefix

    local rcmd
    case $prefix in
    py) rcmd=python ;;
    rb) rcmd=ruby ;;
    pl) rcmd=perl ;;
    go) rcmd=go ;;
    node) rcmd=node ;;
    j) rcmd=java ;;
    jl) rcmd=julia ;;
    R) rcmd=R ;;
    scala) rcmd=scala ;;
    lua) rcmd=lua ;;
    rust) rcmd=rustc ;;
    esac

    p6_return_str "$rcmd"
}
