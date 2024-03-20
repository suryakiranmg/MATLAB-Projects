@echo off
@echo ----------------------------------------------------------------------------------------------------------
@echo.
@echo  Choose the operation from the following list that you wish to perform with this script:
@echo. 
@echo 	1 - Run A2L parser 				- Input:lab,a2l 	Output:xlsx,txt
@echo 		------ Parse Bosch a2l file to txt file for use in Calterm
@echo.
@echo 	2 - Run Combine FIE logs			- Input:csv's,xlsx  	Output:mf4
@echo 		------ Combine csv files from Calterm and xlsx from a2l_parser to mf4 - Calterm MDA files 
@echo.
@echo 	3 - Run Combine INCA and Calterm MDF files	- Input:xlsx,mf4,mf4 	Output:mf4
@echo 		------ Combine mf4 files from INCA and Calterm using the xlsx config file used for synchronization  
@echo.
@echo 	4 - NOT IN USE
@echo.  

set /P input=Enter the Operation to perform (1,2,3,-) ? 
echo %input%, You have selected this. 

if %input%==1 goto :Label_1
if %input%==2 goto :Label_2
if %input%==3 goto :Label_3
if %input%==4 goto :Label_4

:Label_1
set env_name=converter_env
cd ../cmi_data_log_converter
set main=a2l_parser.py
goto :RunTheSript

:Label_2
set env_name=fie_env
set main=combine_fie_logs.py
goto :RunTheSript

:Label_3
set env_name=fie_env
set main=mdf_combine_inca_calterm.py
goto :RunTheSript

:Label_4
set env_name=fie_env
set main=combine_fie_logs.py
goto :RunTheSript

:RunTheSript
call conda activate %env_name% && (python src/%main% || (
    echo.
    echo **********************************************************************
    echo If script works in editor check run_main.bat for correct configuration
    echo Current Values are
    echo    env_name: %env_name%
    echo    main: %main%
    echo **********************************************************************
    )
)
echo.
pause
