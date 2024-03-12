@echo off

set /A globalVar =10
setlocal
set /A localVar = 20
set /A localVar = %localVar% + 30

echo LV = %localVar%
echo GV = %globalVar%

endlocal

echo LV = %localVar%
echo GV = %globalVar%
