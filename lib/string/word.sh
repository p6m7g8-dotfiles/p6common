# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_word__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for word helpers.
######################################################################
p6_word__debug() {
  local msg="$1" # debug message

  p6_debug "p6_word: $msg"

  p6_return_void
}

######################################################################
#<
#
# Function: words words = p6_word_unique(...)
#
#  Args:
#	... - words to uniquify
#
#  Returns:
#	words - words
#
#>
#/ Synopsis
#/    Return unique words from the provided arguments.
######################################################################
p6_word_unique () {
    shift 0 # words to uniquify

    local words
    words="$(
        for pos in "$@"; do
            for i in $pos; do
                printf '%s\n' "$i"
            done
        done | awk '!seen[$0]++'
    )"

    p6_return_words "$words"
}

######################################################################
#<
#
# Function: words result = p6_word_not(a, b)
#
#  Args:
#	a - word list A
#	b - word list B
#
#  Returns:
#	words - result
#
#>
#/ Synopsis
#/    Return words that appear in A but not in B.
######################################################################
p6_word_not() {
  local a="$1" # word list A
  local b="$2" # word list B

  local dir=$(p6_transient_create "word_not" "1")
  local i
  for i in $(echo $a); do
    echo $i
  done >$dir/a
  for i in $(echo $b); do
    echo $i
  done >$dir/b

  local result=$(comm -23 $dir/a $dir/b)

  p6_transient_delete "$dir"

  p6_return_words "$result"
}

######################################################################
#<
#
# Function: true  = p6_word_in(word, ..., words)
#
#  Args:
#	word - word to find
#	... - remaining words
#	words - word list
#
#  Returns:
#	true - 
#	false - 
#
#>
#/ Synopsis
#/    Return true when a word is found in the list.
######################################################################
p6_word_in() {
  local word="$1" # word to find
  shift 1         # remaining words
  local words="$@" # word list

  local found=0
  local i
  for i in $(echo $words); do
    if p6_string_eq "$word" "$i"; then
      found=1
      break
    fi
  done

  if p6_string_eq "$found" "1"; then
    p6_return_true
  else
    p6_return_false
  fi
}
