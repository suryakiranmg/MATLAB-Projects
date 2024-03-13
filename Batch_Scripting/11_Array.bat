@echo off

set myArray=1 2 3 4 5 6 7
(for %%i in (%myArray%) do ( echo %%i ))




set arr[0]=1
set arr[1]=2
set arr[2]=3
set arr[3]=4
echo The first element in array is %arr[0]%
echo The second element in array is %arr[1]%



set i=0
:myLoop

if defined arr[%i%] (
	set /A "i+=1"
	goto :myLoop
)

@echo The length array is %i%
