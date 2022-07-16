# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cmd_ctl_docker_build()
#
#  Environment:	 TERM
#>
######################################################################
p6_cmd_ctl_docker_build() {

  apk --no-cache add ncurses bash

  TERM=xterm-256color
  export TERM
}

######################################################################
#<
#
# Function: p6_cmd_ctl_install([home=pgollucci/home])
#
#  Args:
#	OPTIONAL home - [pgollucci/home]
#
#  Environment:	 HOME SHELL
#>
######################################################################
p6_cmd_ctl_install() {
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
# Function: p6_cmd_ctl_docker_test()
#
#>
######################################################################
p6_cmd_ctl_docker_test() {

  . lib/_bootstrap.sh
  p6_bootstrap "." "github"

  p6_cicd_tests_run
}

######################################################################
#<
#
# Function: p6_cmd_ctl_build(dockerfile)
#
#  Args:
#	dockerfile -
#
#>
######################################################################
p6_cmd_ctl_build() {
  local dockerfile="$1"

  p6_cicd_build_run "$dockerfile"
}
