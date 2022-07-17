# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_ctl_usage()
#
#  Environment:	 EOF
#>
######################################################################
p6_ctl_usage() {
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
# Function: p6_ctl_run(...)
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
p6_ctl_run() {
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
    *) p6_ctl_usage 1 "invalid flag" ;;
    esac
  done
  shift $((OPTIND - 1))

  # grab command
  local cmd="$1"
  shift 1

  # security 101: only allow valid comamnds
  case $cmd in
  help) p6_ctl_usage ;;
  install) ;;
  docker_build) ;;
  docker_test) ;;
  build) ;;
  release) ;;
  *) p6_ctl_usage 1 "invalid cmd" ;;
  esac

  # setup -x based on flag_debug
  [ ${flag_debug} = 1 ] && set -x

  # exit if any cli errors w/ >0 return code
  # the commands can still disable locally if needed
  set -e
  p6_msg "$cmd"
  p6_ctl_cmd_"${cmd}" "$@"
  p6_msg_success "$cmd"
  set +e

  # stop debugging if it was enabled
  [ ${flag_debug} = 1 ] && set +x

  return 0
}

######################################################################
#<
#
# Function: p6_ctl_cmd_docker_build()
#
#  Environment:	 TERM
#>
######################################################################
p6_ctl_cmd_docker_build() {

  apk --no-cache add ncurses bash

  TERM=xterm-256color
  export TERM
}

######################################################################
#<
#
# Function: p6_ctl_cmd_install([home=pgollucci/home])
#
#  Args:
#	OPTIONAL home - [pgollucci/home]
#
#  Environment:	 HOME SHELL
#>
######################################################################
p6_ctl_cmd_install() {
  local home="${1:-pgollucci/home}"

  local root
  local gh_dir
  gh_dir="$HOME/src/github.com/p6"
  root="$gh_dir"

  # Hier
  mkdir -p "$root"

  # Clone
  local p6_org
  p6_org="p6m7g8-dotfiles"
  local repos="$p6_org/p6df-core $p6_org/p6common $home"
  local repo
  for repo in $(echo "$repos"); do
    git clone "https://github.com/$repo" "$root/$repo"
  done

  # Connect
  (
    cd ~

    # connect p6dfz to zsh init files
    rm -f .zlogin .zlogout .zprofile .zshrc .zshenv
    ln -fs "$gh_dir/$p6_org"/p6df-core/conf/zshenv-xdg .zshenv
    ln -fs "$gh_dir/$p6_org"/p6df-core/conf/zshrc .zshrc

    # connect "my" config
    ln -fs "$gh_dir/$home"/.zsh-me .
  )

  # Reload
  echo "reloading...."
  echo exec "$SHELL" -li
}

######################################################################
#<
#
# Function: p6_ctl_cmd_docker_test()
#
#>
######################################################################
p6_ctl_cmd_docker_test() {

  p6_cicd_tests_run
}

######################################################################
#<
#
# Function: p6_ctl_cmd_build(dockerfile)
#
#  Args:
#	dockerfile -
#
#>
######################################################################
p6_ctl_cmd_build() {
  local dockerfile="$1"

  p6_cicd_build_run "$dockerfile"
}
