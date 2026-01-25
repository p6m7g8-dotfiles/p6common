# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_ctl_usage([rc=0], [msg=])
#
#  Args:
#	OPTIONAL rc - exit code [0]
#	OPTIONAL msg - optional message []
#
#  Environment:	 P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
#>
#/ Synopsis
#/    Print usage and exit with the specified code.
######################################################################
p6_ctl_usage() {
  local rc="${1:-0}"  # exit code
  local msg="${2:-}" # optional message

  if p6_string_blank_NOT "$msg"; then
    p6_msg "$msg"
  fi
  cat <<EOF
Usage: bin/p6ctl [-D|-d] [cmd]

Options:
  -D    debeug off
  -d	debug on

Cmds:
  help
EOF

  p6_file_display "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common/lib/stdlib/ctl.sh" | p6_filter_row_select "^p6_ctl_cmd" | p6_filter_extract_before "(" | p6_filter_extract_after "p6_ctl_cmd_" | p6_filter_translate_start_to_arg "  " | p6_filter_sort

  exit "$rc"
}

######################################################################
#<
#
# Function: p6_ctl_run(...)
#
#  Args:
#	... - arguments for p6ctl
#
#>
#/ Synopsis
#/    Parse CLI arguments and dispatch a p6ctl subcommand.
######################################################################
p6_ctl_run() {
  shift 0 # arguments for p6ctl

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
  local cmd="$1" # subcommand name
  shift 1        # remaining subcommand args

  # security 101: only allow valid comamnds
  case $cmd in
  help) p6_ctl_usage ;;
  install) ;;
  build) ;;
  test) ;;
  docker_build) ;;
  docker_test) ;;
  deploy) ;;
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
#/ Synopsis
#/    Prepare docker build environment dependencies.
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
#	OPTIONAL home - GitHub repo for home config [pgollucci/home]
#
#  Environment:	 HOME SHELL
#>
#/ Synopsis
#/    Install p6 dotfiles into a target home repo.
######################################################################
p6_ctl_cmd_install() {
  local home="${1:-pgollucci/home}" # GitHub repo for home config

  local root
  local gh_dir
  gh_dir="$HOME/.p6"
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
#/ Synopsis
#/    Run the test suite in a docker environment.
######################################################################
p6_ctl_cmd_docker_test() {

  p6_cicd_tests_run
}

######################################################################
#<
#
# Function: p6_ctl_cmd_test()
#
#>
#/ Synopsis
#/    Run the module test suite.
######################################################################
p6_ctl_cmd_test() {

  p6_cicd_tests_run "$@"
}

######################################################################
#<
#
# Function: p6_ctl_cmd_build(dockerfile)
#
#  Args:
#	dockerfile - Dockerfile path
#
#>
#/ Synopsis
#/    Build the module using a Dockerfile.
######################################################################
p6_ctl_cmd_build() {
  local dockerfile="$1" # Dockerfile path

  p6_cicd_build_run "$dockerfile"
}
