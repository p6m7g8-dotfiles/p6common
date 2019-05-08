p6df::modules::p6common::version()        { echo "0.0.1"; }
p6df::modules::p6common::deps()           { true; }
p6df::modules::p6common::external::brew() { true; }
p6df::modules::p6common::home::symlink()  { true; }

p6df::modules::p6common::init() {

  p6_init "$P6_DFZ_SRC_DIR/p6m7g8/p6common"
}

p6_init() {
  local dir="$1"

  . "$dir"/lib/io.sh
  . "$dir"/lib/debug.sh
  . "$dir"/lib/string.sh
  . "$dir"/lib/file.sh

  local file
  for file in "$dir"/lib/*.sh; do
    P6_DEBUG=1 p6_file_load "$file"
  done
}
