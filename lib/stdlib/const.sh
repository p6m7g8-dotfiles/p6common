# shellcheck shell=bash

#
# These are intentionally global.  No global should exist without being
# delcared here first.  Other modules may add local namespace prefixed globals
# that are internal to it.
#
TMPDIR=${TMPDIR:-/tmp}

P6_DIR=$TMPDIR/p6
P6_DIR_TRANSIENTS=$P6_DIR/transients

P6_TRANSIENT_LOG=$P6_DIR_TRANSIENTS/list-$$.txt

P6_TRUE=0
P6_FALSE=1

P6_RETURN_SUCCESS=0
P6_RETURN_FAIL=1

P6_EXIT_SUCCESS=0
P6_EXIT_FAIL=1
P6_EXIT_ARGS=2
P6_EXIT_FATAL=25
P6_EXIT_ASKED=42

P6_NL="
"

P6_DEBUG=all
P6_VERBOSE=
P6_DRY_RUN=
