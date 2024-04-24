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
# Function: p6_filter_aggregrate_table_by_group([sep=\t])
#
#  Args:
#	OPTIONAL sep - [\t]
#
#  Environment:	 IFS
#>
#/  Synopsis:
#/	Input
#/		group c1 c2 c3...
#/		group c1 c2 c3...
#/ 	  We're aggregrating group lines here
######################################################################
p6_filter_aggregrate_table_by_group() {
	local sep="${1:-\t}"

	local line
	while IFS="$sep" read -r line; do
		local column_count=$(p6_echo "$line" | p6_filter_columns_count "$sep")
		local group=$(p6_echo "$line" | p6_filter_column_pluck "1")
		# columns are 1 based
		# first column is the group
		local i=2
		while p6_math_lte "$i" "$column_count"; do
			local col=$(p6_echo "$line" | p6_filter_column_pluck "$i")

			# Find or Create Group
			# Find or Create Col
			# Update Col=Previous+Col
			i=$(p6_math_inc "$i" "1")
		done
	done

	# Output all unique groups with col totals
}
