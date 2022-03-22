# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_test_dir(test_path)
#
#  Args:
#	test_path -
#
#  Depends:	 p6_test
#  Environment:	 LC_ALL P6_TEST_DIR_ROOT
#>
######################################################################
p6_test_dir() {
    local test_path="$1"

    local dir_name
    if [ -z "$test_path" ]; then
	dir_name=$P6_TEST_DIR_ROOT
    else
	local rand=$(cat /dev/urandom | env LC_ALL=C tr -dc a-zA-Z0-9 | head -c 5)
	dir_name="$test_path/$rand"

	mkdir -p $dir_name
    fi

    echo $dir_name
}

######################################################################
#<
#
# Function: p6_test__init()
#
#  Depends:	 p6_test
#  Environment:	 P6_DIR P6_LF P6_TEST_BAIL_FILE P6_TEST_DIR P6_TEST_DIR_ORIG P6_TEST_DIR_ROOT TMPDIR
#>
######################################################################
p6_test__init() {

    P6_LF='
'
    local tmpdir=${TMPDIR:-/tmp}
    P6_DIR=$tmpdir/p6

    P6_TEST_DIR=$P6_DIR/test
    P6_TEST_DIR_ROOT=

    P6_TEST_BAIL_FILE=$P6_TEST_DIR/bail

    P6_TEST_DIR_ORIG=`pwd`
}

######################################################################
#<
#
# Function: p6_test__initialize(n)
#
#  Args:
#	n -
#
#  Depends:	 p6_test
#  Environment:	 P6_TEST_DIR
#>
######################################################################
p6_test__initialize() {
    local n="$1"

    p6_test__init
    trap p6_test_teardown 0 1 2 3 6 14 15
    mkdir -p $P6_TEST_DIR

    echo 1 > $P6_TEST_DIR/i
    echo "$n" > $P6_TEST_DIR/n
}

######################################################################
#<
#
# Function: p6_test__prep()
#
#  Depends:	 p6_test
#  Environment:	 P6_TEST_DIR_ORIG P6_TEST_DIR_ROOT
#>
######################################################################
p6_test__prep() {

    P6_TEST_DIR_ROOT=$(p6_test_dir "$P6_TEST_DIR")

    if [ -d $P6_TEST_DIR_ORIG/fixtures ]; then
	cp -R $P6_TEST_DIR_ORIG/fixtures $P6_TEST_DIR_ROOT/
    fi

    cd $P6_TEST_DIR_ROOT
}

######################################################################
#<
#
# Function: p6_test__bailout()
#
#  Depends:	 p6_test
#  Environment:	 P6_TEST_BAIL_FILE
#>
######################################################################
p6_test__bailout() {

    echo 1 > $P6_TEST_BAIL_FILE
}

######################################################################
#<
#
# Function: p6_test__cleanup()
#
#  Depends:	 p6_test
#  Environment:	 P6_TEST_BAIL_FILE P6_TEST_DIR_ORIG P6_TEST_DIR_ROOT
#>
######################################################################
p6_test__cleanup() {

    cd $P6_TEST_DIR_ORIG
    rm -rf $P6_TEST_DIR_ROOT

    if [ -e $P6_TEST_BAIL_FILE ]; then
	rm -f $P6_TEST_BAIL_FILE
	return 0
    else
	rm -f $P6_TEST_BAIL_FILE
	return 1
    fi
}

######################################################################
#<
#
# Function: p6_test__i()
#
#  Environment:	 P6_TEST_DIR
#>
######################################################################
p6_test__i() {

    local current=$(cat $P6_TEST_DIR/i)
    local next=$(($current+1))

    echo $next > $P6_TEST_DIR/i

    echo $current
}
