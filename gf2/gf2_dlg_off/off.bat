@echo off

set s1=audiostreams
for /D %%i in (%s1%\*x_0 %s1%\??) do ren %%i %%~ni.off
ren *.VIV *.OFF 2>nul

timeout /t 5
