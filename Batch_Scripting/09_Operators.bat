@echo off
set /A a=50
set /A b=100
set /A c=120

REM -----------------------Arithmetic Operators
@echo ---------------------Sum Numbers
set /A sum = %a% + %b%
echo %sum%

@echo ---------------------Subtract Numbers
set /A sum = %a%-%b%
echo %sum%

@echo ---------------------Multiply Numbers
set /A sum = %a% * %b%
echo %sum%

@echo ---------------------Divide Numbers
set /A sum = %b%/%a%
echo %sum%

@echo ---------------------Percentage Numbers
set /A sum = %c% %% %a%
echo %sum%

REM ------------------------Relational Operators

if %a% EQU %b% echo A is equal to B
if %a% NEQ %b% echo A is NOT equal to B
if %a% LSS %b% echo A is less than B
if %a% LEQ %b% echo A is less than or equal to B
if %a% GTR %b% echo A is greater than B
if %a% GEQ %b% echo A is greater than or equal to B

REM ------------------------Logical Operators

if %a% GEQ 100 (
	if %b% LEQ 0 (
		echo %a% is greater than 100 and %b% is less than 0
	) else (
	echo %a% is greater than 100 and %b% is NOT less than 0
	)
	) else (
		echo %a% is NOT less than 100 
)
	
REM ------------------------Assignment Operators
set /A num=100

set /A num += 50
echo Add : %num%

set /A num -= 50
echo Sub : %num%

set /A num *= 50
echo Multiply : %num%

set /A num /= 50
echo Divide : %num%

set /A num %%= 50
echo Percentage : %num%
	
REM ------------------------Bitwise Operators

set /A "and = 7 & 4" 
echo AND : %and%

set /A "or = 7 | 4" 
echo OR : %or%

set /A "xor = 7 ^ 4" 
echo XOR : %xor%























