# shellcheck shell=bash

p6_return_true() { return $P6_TRUE   }
p6_return_false() { return $P6_FALSE }
p6_return_void() { return }
p6_return_bool() { return "$1" }
p6_return_size_t() { echo "$1" }
p6_return_int() { echo "$1" }
p6_return_float() { echo "$1" }
p6_return_filter() { return "$?" }
p6_return_ipv4() { echo "$1" }
p6_return_stream() { return "$P6_TRUE" }
p6_return_str() { echo "$1" }
p6_return_path() { echo "$1" }
p6_return_date() { echo "$1" }
p6_return_words() { echo "$1" }
p6_return_code_as_value() { echo "$1" }
p6_return_code_as_code() { return "$1" }
p6_return() { echo "$1"; return $P6_TRUE }
