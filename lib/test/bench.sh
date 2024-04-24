# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_test_bench()
#
#  Environment:	 BEGIN END
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
        d=$(awk -v d="$d" -v di="$di" 'BEGIN { print d + di }')

        local lt=$(awk -v di="$di" -v m="$m" 'BEGIN { print (di < m) ? 1 : 0 }')
        local gt=$(awk -v di="$di" -v M="$M" 'BEGIN { print (di > M) ? 1 : 0 }')

        if [ $lt -eq 1 -o $i -eq $times ]; then
            m=$di
        fi
        if [ $gt -eq 1 ]; then
            M=$di
        fi

        data="$data $di"
        i=$(($i - 1))
        echo ".\c"
    done

    local a=$(awk -v d="$d" -v times="$times" 'BEGIN { printf "%.3f\n", d / times }')
    local s=$(echo "$data" | tr " " "\n" | awk '$1+0 == $1 { sum+=$1; sumsq+=$1*$1; cnt++ } END { print sumsq/cnt; print sqrt(sumsq/cnt-(sum/cnt)**2) }' | xargs)

    echo
    echo "Avg=${a}s Std=${s}s"
    echo "Min=${m}s Max=${M}s Total=${d}s"
}
