@echo off

@echo ---------Check Strings----------- 
set a="Hello, People!"
set b=

if [%a%]==[] echo "A is Empty"
if [%b%]==[] echo "B is Empty"


@echo ---------Concatenate Strings------
set first=Hello
set second=World

set finalString=%first% and %second%
echo %finalString%


@echo --------Interpolate Strings------
set first=Hello
set second=World
set /A num=2024

set finalString=%first% %second% %num%
echo %finalString%


@echo --------Extract from String------
set str=HelloSuki Have a nice day!
echo.%str%

REM Left String
set Lstr=%str:~0,7%
echo.%Lstr%

REM Right String
set Rstr=%str:~-16%
echo.%Rstr%

REM Mid String
set Mstr=%str:~5,4%
echo.%Mstr%

