# Scripts
## Random collection of scripts

### hashcat-bench-to-csv
Creates a CSV from hashcat benchmark output.  
**example usage**
  1. hashcat -b > nvidia-2080ti.txt
  2. ./hashcat-bench-to-csv.sh nvidia-2080ti.txt hashcat-nvida-2080ti.csv
 
 **sample output**  
Mode,Type,Rate
0,"MD5",106.5 GH/s
11,"Joomla < 2.5.18",101.5 GH/s
20,"md5($salt.$pass)",56473.7 MH/s
22,"Juniper NetScreen/SSG (ScreenOS)",57464.4 MH/s
30,"md5(utf16le($pass).$salt)",104.0 GH/s
50,"HMAC",16293.5 MH/s
100,"SHA1",29769.0 MH/s
