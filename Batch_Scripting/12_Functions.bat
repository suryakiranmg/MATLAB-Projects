@echo off

setlocal

rem call :Function1
rem exit /B %Errorlevel%

rem :Function1
rem set /A age=30
rem echo The age is %age%
rem exit /B 0



call :ShowParamFun 10,20,30,40
exit /B %Errorlevel%

:ShowParamFun
echo The first argument is %~1
echo The first argument is %~2
echo The first argument is %~3
echo The first argument is %~4
exit /B 0
