# Scripts
## Random collection of scripts

### [hc-benchmark-csv](https://github.com/Imp0ster-EH/Scripts/blob/master/hc-benchmark-csv.sh)
Creates a CSV from hashcat benchmark output.  
**example usage**
  1. hashcat -b > nvidia-2080ti.txt
  2. ./hc-benchmark-csv.sh aws-p3.16xlarge-benchmark.txt [output-file.csv]  
     2.1 The optional second argument specifies the output filename.  The defualt is the device name prepended with 'single' or 'multi'
 
 **sample output**
```multi-Tesla-V100-SXM2-16GB-403816152-MB-allocatable-80MCU.csv```
```Mode,Type,Rate  
0,"MD5",106.5 GH/s  
11,"Joomla < 2.5.18",101.5 GH/s  
20,"md5($salt.$pass)",56473.7 MH/s  
22,"Juniper NetScreen/SSG (ScreenOS)",57464.4 MH/s  
30,"md5(utf16le($pass).$salt)",104.0 GH/s  
50,"HMAC",16293.5 MH/s  
100,"SHA1",29769.0 MH/s
```
