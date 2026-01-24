# shellcheck shell=zsh

p6_test_cdx_bootstrap() {
  local base_dir="$1"

  local dir
  dir="$base_dir/lib/test-codex"

  . "$dir/state.sh"
  . "$dir/tap.sh"
  . "$dir/api.sh"
  . "$dir/run.sh"
  . "$dir/asserts.sh"
  . "$dir/harness.sh"
}
