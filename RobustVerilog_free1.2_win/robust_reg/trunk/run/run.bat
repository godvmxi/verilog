
echo off

..\..\..\robust.exe ../src/base/regfile.h -od out -header -gui
..\..\..\robust.exe ../src/base/regfile.html -od out -gui
..\..\..\robust.exe ../src/base/regfile.v -od out -list list.txt -listpath  -header -gui

