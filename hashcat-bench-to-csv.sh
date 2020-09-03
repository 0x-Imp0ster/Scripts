#!/bin/bash
# Process hashcat bechmark results into CSV file

function usage {
	echo -e "\n\tA script to read in hashcat benchmarks and output the hashrates to CSV"
	echo -e "\n\tUsage: $0 <input file> <output file>\n"
	exit 1
}

[ $# -lt 2 ] && { usage; }

INFILE="$1"
OUTFILE="$2"

# Create CSV header
echo "Creating output file: $OUTFILE"
echo -e "Mode,Type,Rate" > $OUTFILE

# Strip benchmark results to two lines per mode - the bits we need
echo "DEBUG: Creating temp file..."
TMPFILE=$(mktemp "benchmark-tmp.XXXXX")
exec 3>"$TMPFILE"
echo "DEBUG: tmp file: $TMPFILE"
cat $INFILE | grep -E 'Hashmode:|Speed\.Dev\.#\*' >&3

echo "DEBUG: Head of tmp file:"
head -10 $TMPFILE

# Read in the tmp file 2 rows at a time to extract the fields we need and then append them to the CSV

while read -r ROW1 && read -r ROW2; do
	MODE=$(echo $ROW1 | awk '$1 == "Hashmode:" {print $2}')
	TYPE=$(echo $ROW1 | awk -F "-" '{print "\""$2"\""}' | sed -e 's/^"[[:space:]]*/"/')
	RATE=$(echo $ROW2 | grep -Eo '[0-9]{1,5}\.?[0-9]?\s[GHkM]{1,2}\/s')
	echo -e "$MODE,$TYPE,$RATE" >> $OUTFILE
done < $TMPFILE

# Cleanup
rm $TMPFILE

exit
