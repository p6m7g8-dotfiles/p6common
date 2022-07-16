# shellcheck shell=bash

######################################################################
#<
#
# Function: p6df_usage([rc=0], [msg=])
#
#  Args:
#	OPTIONAL rc - [0]
#	OPTIONAL msg - []
#
#  Environment:	 EOF
#>
#/ Synopsis
#/    bin/p6ctl [-D|-d] [cmd]
#/
######################################################################
p6df_usage() {
  local rc="${1:-0}"
  local msg="${2:-}"

  if [ -n "$msg" ]; then
    p6_msg "$msg"
  fi
  cat <<EOF
Usage: bin/p6ctl [-D|-d] [cmd]

Options:
  -D    debeug off
  -d	debug on

Cmds:
  help
  doc
  module update
  module fetch
EOF

  exit "$rc"
}

p6ctl_usage() {
  local rc="${1:-0}"
  local msg="${2:-}"

  if [ -n "$msg" ]; then
    p6_msg "$msg"
  fi
  cat <<EOF
Usage: bin/p6ctl [-D|-d] [cmd]

Options:
  -D    debeug off
  -d	debug on

Cmds:
  help
  install
  build
  docker_build
  docker_test
  release
EOF

  exit "$rc"
}

######################################################################
#<
#
# Function: p6_function_p6ctl(...)
#
#  Args:
#	... - 
#
#  Environment:	 LC_ALL OPTIND
#>
#/ Synopsis
#/    bin/p6ctl [-D|-d] [cmd]
#/
#/ Synopsis
#/    The entry point for bin/p6ctl
#/
######################################################################
p6_function_p6ctl() {
  shift 0

  # sanitize env
  LC_ALL=C

  # default options
  local flag_debug=0

  # parse options
  local flag
  while getopts "dD" flag; do
    case $flag in
    D) flag_debug=0 ;;
    d) flag_debug=1 ;;
    *) p6ctl_usage 1 "invalid flag" ;;
    esac
  done
  shift $((OPTIND - 1))

  # grab command
  local cmd="$1"
  shift 1

  # security 101: only allow valid comamnds
  case $cmd in
  help) p6ctl_usage ;;
  install) ;;
  docker_build) ;;
  docker_test) ;;
  build) ;;
  release) ;;
  *) p6ctl_usage 1 "invalid cmd" ;;
  esac

  # setup -x based on flag_debug
  [ ${flag_debug} = 1 ] && set -x

  # exit if any cli errors w/ >0 return code
  # the commands can still disable locally if needed
  set -e
  p6_msg "$cmd"
  p6_cmd_ctl_"${cmd}" "$@"
  p6_msg_success "$cmd"
  set +e

  # stop debugging if it was enabled
  [ ${flag_debug} = 1 ] && set +x

  return 0
}

######################################################################
#<
#
# Function: p6_function_p6df(...)
#
#  Args:
#	... - 
#
#  Environment:	 LC_ALL OPTIND
#>
#/ Synopsis
#/    The entry point for bin/p6ctl
#/
######################################################################
p6_function_p6df() {
  shift 0

  # sanitize env
  LC_ALL=C

  # default options
  local flag_debug=0

  # parse options
  local flag
  while getopts "dD" flag; do
    case $flag in
    D) flag_debug=0 ;;
    d) flag_debug=1 ;;
    *) p6df_usage 1 "invalid flag" ;;
    esac
  done
  shift $((OPTIND - 1))

  # grab command
  local cmd="$1"
  shift 1

  # security 101: only allow valid comamnds
  case $cmd in
  help) p6df_usage ;;
  doc) ;;
  module) ;;
  *) p6df_usage 1 "invalid cmd" ;;
  esac

  # setup -x based on flag_debug
  [ ${flag_debug} = 1 ] && set -x

  # exit if any cli errors w/ >0 return code
  # the commands can still disable locally if needed
  set -e
  p6_msg "$cmd"
  p6_cmd_df_"${cmd}" "$@"
  p6_msg_success "$cmd"
  set +e

  # stop debugging if it was enabled
  [ ${flag_debug} = 1 ] && set +x

  return 0
}
