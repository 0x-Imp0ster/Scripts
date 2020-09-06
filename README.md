# Scripts
## Random collection of scripts

### [hc-benchmark-csv](https://github.com/Imp0ster-EH/Scripts/blob/master/hc-benchmark-csv.sh)
Creates a CSV from hashcat benchmark output.  
**example usage**
```
$./hc-benchmark.sh aws-p3.16xlarge-benchmark.txt 
Multi-card benchmark detected

 Reading file: aws-p3.16xlarge-benchmark.txt
 Removed tmp file

Done
 Output file: multi-Tesla-V100-SXM2-16GB-403816152-MB-allocatable-80MCU.csv

$ head -5 multi-Tesla-V100-SXM2-16GB-403816152-MB-allocatable-80MCU.csv 
Mode,Type,Hashrate
900,"MD4",652.3 GH/s
0,"MD5",450.0 GH/s
5100,"Half MD5",281.5 GH/s
100,"SHA1",135.0 GH/s
```
