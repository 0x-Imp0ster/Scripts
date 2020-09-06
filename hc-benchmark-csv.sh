#!/bin/bash
# Process hashcat bechmark results into CSV file
# Requires 'mktemp'

function usage {
	echo -e "\n\tA script to read in hashcat benchmarks and output the hashrates to CSV"
	echo -e "\n\tUsage: $0 <input file> [output file (Default: device-name.csv)]\n"
	exit 1
}

function singleCard() {

	OUTFILE="single-"$OUTFILE
	echo "Mode,Type,Hashrate" > $OUTFILE

	echo -e "Single card benchmark detected"
	echo -e "Creating CSV: '$OUTFILE'...\n"

	# create tmp file that is stripped down to mode and speed lines
	TMPSINGLE=$(mktemp "benchmark-single-XXXXX.tmp")
	#echo -e "DEBUG:\tTMP file: $TMPSINGLE"
	cat $INFILE | grep -E 'Hashmode:|Speed\.#1' > $TMPSINGLE
	echo -e " Reading file: $INFILE"

	# extract key data from the tmp file and append to CSV
	while read -r ROW1 && read -r ROW2; do
		MODE=$(echo $ROW1 | awk '$1 == "Hashmode:" {print $2}' | sed -E 's/^\s//g')
		TYPE=$(echo $ROW1 | awk -F "Hashmode:" '{print $2}' | sed -E 's/^\s[0-9]{1,6}\s-\s//g')
		RATE=$(echo $ROW2 | grep -Eo '[0-9]{1,5}\.?[0-9]?\s[GHkM]{1,2}\/s')
		echo -e "$MODE,\"$TYPE\",$RATE" >> $OUTFILE
	done < $TMPSINGLE
	rm $TMPSINGLE && echo -e " Removed tmp file"
	echo -e "\nDone"
	echo -e "\tOutput file: $OUTFILE"
	#echo -e "DEBUG:\tOutput sample:"
	#head $OUTFILE
}

function multiCard() {

	OUTFILE="multi-"$OUTFILE
	echo "Mode,Type,Hashrate" > $OUTFILE

	echo -e "Multi-card benchmark detected"
	echo -e "Creating CSV: '$OUTFILE'...\n"

	# create tmp file that is stripped down to mode and speed lines
	TMPMULTI=$(mktemp "benchmark-multi-XXXXX.tmp")
	#echo -e "DEBUG:\tTMP file: $TMPMULTI"
	cat $INFILE | grep -E 'Hashmode:|Speed\..*#\*' > $TMPMULTI
	echo -e " Reading file: $INFILE"

	# extract key data from the tmp file and append to CSV
	while read -r ROW1 && read -r ROW2; do
		MODE=$(echo $ROW1 | awk '$1 == "Hashmode:" {print $2}' | sed -E 's/^\s//g')
		TYPE=$(echo $ROW1 | awk -F "Hashmode:" '{print $2}' | sed -E 's/^\s[0-9]{1,6}\s-\s//g')
		RATE=$(echo $ROW2 | grep -Eo '[0-9]{1,5}\.?[0-9]?\s[GHkM]{1,2}\/s')
		echo -e "$MODE,\"$TYPE\",$RATE" >> $OUTFILE
	done < $TMPMULTI
	rm $TMPMULTI && echo -e " Removed tmp file"
	echo -e "\nDone"
	echo -e " Output file: $OUTFILE"
	#echo -e "DEBUG:\tOutput sample:"
	#head $OUTFILE
}

# check arguments and print usage
[ $# -lt 1 ] && { usage; }

INFILE="$1"
# Output file defaults to device-name.csv
OUTFILE=${2:-DEFAULT}

# If no output file defined, set it here
if [ $OUTFILE == "DEFAULT" ]; then
	#echo -e "DEBUG:\tSetting output filename..."
	OUTFILE=$(cat $INFILE | grep -Eo 'Device\s#1.+allocatable.+$' | awk -F "Device #1: " '{print $2}' | sed 's/[,/\*]//g' | sed 's/ /-/g')
	OUTFILE="$OUTFILE.csv"
	#echo -e "DEBUG:\tOutput file: $OUTFILE"
fi

# Check if we have a single or multi-card benchmark
if cat $INFILE | grep -qE 'Speed.+#2';then
	multiCard
else
	singleCard
fi
