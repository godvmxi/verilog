
echo off

for /f %%f IN ('dir /b robust_*') do (
 cd %%f\trunk\run
 call run.bat
 cd ..\..\..
)
