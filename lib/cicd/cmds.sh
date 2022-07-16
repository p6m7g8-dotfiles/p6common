######################################################################
#<
#
# Function: p6_cmd_docker_build()
#
#  Environment:	 TERM
#>
######################################################################
p6_cmd_docker_build() {

    apk --no-cache add ncurses bash

    TERM=xterm-256color
    export TERM
}

######################################################################
#<
#
# Function: p6_cmd_install([home=pgollucci/home])
#
#  Args:
#	OPTIONAL home - [pgollucci/home]
#
#  Environment:	 HOME SHELL
#>
######################################################################
p6_cmd_install() {
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
    local repos="$p6_org/p6df-core $p6_org/p6ctl $home"
    local repo
    for repo in $(echo "$repos"); do
        gh repo clone "$repo" "$root/$repo"
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
# Function: p6_cmd_docker_test()
#
#>
######################################################################
p6_cmd_docker_test() {

    . lib/_bootstrap.sh
    p6_bootstrap "." "github"

    p6_cicd_tests_run
}

######################################################################
#<
#
# Function: p6_cmd_doc()
#
#>
######################################################################
p6_cmd_doc() {

  p6df::core::module::use "p6m7g8-dotfiles/p6df-perl"
  p6_cicd_doc_gen
}

######################################################################
#<
#
# Function: p6_cmd_module(sub_cmd, module)
#
#  Args:
#	sub_cmd -
#	module -
#
#>
######################################################################
p6_cmd_module() {
  local sub_cmd="$1"
  local module="$2"

  p6df::core::module::use "p6m7g8-dotfiles/p6git"

  (
    set +e
    p6_cmd_"${sub_cmd}" "$module"
  )
}

p6_cmd_use() {     local module="$1"; p6df::core::module::use "$module" }
p6_cmd_fetch() {   local module="$1"; p6df::core::module::fetch "$module" }
p6_cmd_update() {  local module="$1"; p6df::core::module::update "$module" }
p6_cmd_vscodes() { local module="$1"; p6df::core::module::vscodes "$module" }
p6_cmd_langs() {   local module="$1"; p6df::core::module::use "$module"; p6df::core::module::langs "$module" }

# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_usage()
#
#  Environment:	 EOF
#>
#/ Synopsis
#/    bin/p6ctl [-D|-d] [cmd]
#/
######################################################################
p6_usage() {
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
  doc
  build
  module
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
    *) p6_usage 1 "invalid flag" ;;
    esac
  done
  shift $((OPTIND - 1))

  # grab command
  local cmd="$1"
  shift 1

  # security 101: only allow valid comamnds
  case $cmd in
  help) p6_usage ;;
  install) ;;
  doc) ;;
  docker_build) ;;
  docker_test) ;;
  build) ;;
  module) ;;
  release) ;;
  *) p6_usage 1 "invalid cmd" ;;
  esac

  # setup -x based on flag_debug
  [ ${flag_debug} = 1 ] && set -x

  # exit if any cli errors w/ >0 return code
  # the commands can still disable locally if needed
  set -e
  p6_msg "$cmd"
  p6_cmd_"${cmd}" "$@"
  p6_msg_success "$cmd"
  set +e

  # stop debugging if it was enabled
  [ ${flag_debug} = 1 ] && set +x

  return 0
}
