<center><big>all demo codes for new gays</big></center><span style=""></span>



You can use the robust-lite.exe tool in linux system with wine installed: 
######################################################################### 
#!/bin/bash 
# 
# DESCRIPTION 
# simple script to generate Verilog from RobustVerilog files 
# 
# NOTES 
# - wine always requires full paths 
# 
# - error messages redirect to /dev/null 
# 
# wine: cannot find L"C:\\windows\\system32\\wineboot.exe" 
# err:process:start_wineboot failed to start wineboot, err 2 
# 
# SOURCE 

BASE_DIR=/local/work/robust_v 

ROBUST=$BASE_DIR/bin/robust-lite.exe 
SRC=$BASE_DIR/robust_ahb_matrix/trunk/src/base/ahb_matrix.v 
INC=$BASE_DIR/robust_ahb_matrix/trunk/src/gen 
OUT=$BASE_DIR/src_gen 

mkdir -p $OUT 
echo "start" 
echo "wine $ROBUST $SRC -od $OUT -I $INC -list list.txt -listpath -header" 

wine $ROBUST $SRC -od $OUT -I $INC -list list.txt -listpath -header 2> /dev/null 

#########################################################################
