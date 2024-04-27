# shellcheck shell=bash
#
######################################################################
#<
#
# Function: p6_filter_aggregrate_map_reduce()
#
#>
######################################################################
p6_filter_aggregrate_map_reduce() {

	sort | uniq -c
}

######################################################################
#<
#
# Function: p6_filter_aggregrate_table_by_group_with_count([sep=\t])
#
#  Args:
#	OPTIONAL sep - [\t]
#
#  Environment:	 BEGIN END SUBSEP
#>
#/  Synopsis:
#/	Input
#/		group c1 c2 c3...
#/		group c1 c2 c3...
#/ 	  We're aggregrating group lines here
######################################################################
p6_filter_aggregrate_table_by_group_with_count() {
	local sep="${1:-\t}"

	awk 'BEGIN { FS="\t" }

{
    group = $1

    # Count total records per group
    recordCount[group]++

    for (i = 2; i <= NF; i++) {
        key = group SUBSEP i
        tallies[key] += $i
        counts[key]++
    }
}

END {
    for (group in recordCount) {
        # Print group name and total record count for this group
        printf "%-18s\t%d", group, recordCount[group]

        # Generate averages for each additional field tracked by the group
        for (i = 3; i <= NF; i++) {  # Start from the third field to skip the group column
            key = group SUBSEP i
            if (key in tallies) {
                average = (counts[key] > 0) ? tallies[key] / counts[key] : 0
                printf "\t%.3f", average
            } else {
                printf "\t0.000"  # No data for this column in any record
            }
        }
        printf "\n"
    }
}'

}

######################################################################
#<
#
# Function: p6_filter_aggregrate_table_with_count([sep=\t])
#
#  Args:
#	OPTIONAL sep - [\t]
#
#  Environment:	 BEGIN END
#>
######################################################################
p6_filter_aggregrate_table_with_count() {
	local sep="${1:-\t}"

	awk '
BEGIN { FS="\t" }

{
    group = $1

    totalCount += $2

    # Sum each field across all records
    for (i = 3; i <= NF; i++) {
        totalSum[i] += $i
    }
}

END {
    # Print total record count
    printf "%d", totalCount

    # Calculate and print average for each field starting from the second
    for (i = 3; i <= NF; i++) {
        average = totalSum[i] / totalCount
        printf "\t%.3f", average
    }
    printf "\n"
}

'

}
