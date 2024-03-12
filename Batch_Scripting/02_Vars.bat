@echo off

echo %1
echo %2
echo %3
REM echo %4
REM echo %5


REM set /A VarName=val1    /A for non-numerical values

set sayOutLoud = Hello World!!
echo %sayOutLoud%

set /A first=10
set /A second=20
set /A add = %first% + %second%

echo Sum is %add%
