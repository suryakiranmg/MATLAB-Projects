@echo off

set /A lower_limit = 1
set /A loop_increment = 1
set /A upper_limit = 10

for /L %%i in (%lower_limit%,%loop_increment%,%upper_limit%) do (
		echo %%i)

  
		
@echo Reverse loop
set /A lower_limit = 10
set /A loop_increment = -2
set /A upper_limit = 1

for /L %%i in (%lower_limit%,%loop_increment%,%upper_limit%) do (
		echo %%i)
