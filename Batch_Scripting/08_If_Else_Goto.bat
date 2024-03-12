@echo off
@echo ----------------Compare Numeric values
set /A a=50
set /A b=10
set /A sum=%a%+%b%

if %sum%==60 echo "The Sum is 60"
if %sum%==50 echo "The Sum is 50"

@echo ----------------Compare Strings
set str1=Hello
set str2=World

if %str1%==Hello echo "The strings match; its Hello"
if %str2%==Suki echo "The strings match; its Suki"

@echo -----------------if-else statements
if %str1%==Hello (echo "Strings match; its Hello") else (echo "Unknown Value")

if %str2%==Suki (echo "Strings match; its World") else (echo "Unknown Value")

@echo ----------------Nested if-else statements
set /A first=10
set /A second=20
if %first%==10 if %second%==20 echo "Both if conditions are true"

@echo ----------------GoTo statements
set /A a=100

if %a%==50 goto :Label_1
if %a%==100 goto :Label_2

:Label_1
echo "Label_1 : Value is 50"
exit /b 0

:Label_2
echo "Label_2 : Value is 100"

