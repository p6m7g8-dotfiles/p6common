# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_test_bench()
#
#  Environment:	 END
#>
######################################################################
p6_test_bench() {
    local times="$1"
    local thing="$2"

    echo "1..$times"

    local d=0

    local m=0
    local M=0
    local i=$times

    local data=
    while [ $i -gt 0 ]; do
	local vals=$(p6_test_harness_test_run "$thing")
	local di=$(echo $vals | grep -o 'd=[0-9.\-]*' | sed -e 's,d=,,')
	d=$(echo "$d+$di" | bc -q)

	local lt=$(echo "$di < $m" | bc -lq)
	local gt=$(echo "$di > $M" | bc -lq)

	if [ $lt -eq 1 -o $i -eq $times ]; then
	    m=$di
	fi
	if [ $gt -eq 1 ]; then
	    M=$di
	fi

	data="$data $di"
	i=$(($i-1))
	echo ".\c"
    done

    local a=$(echo "scale=3; ($d/$times)" | bc -lq)
    local s=$(echo "$data" | tr " " "\n" | awk '$1+0 == $1 { sum+=$1; sumsq+=$1*$1; cnt++ } END { print sumsq/cnt; print sqrt(sumsq/cnt-(sum/cnt)**2) }' | xargs)

    echo
    echo "Avg=${a}s Std=${s}s"
    echo "Min=${m}s Max=${M}s Total=${d}s"
}
