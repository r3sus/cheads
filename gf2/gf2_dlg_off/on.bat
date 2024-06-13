@echo off

for /D %%i in (audiostreams\*.off) do ren %%i %%~ni
ren *.OFF *.VIV 2>nul

timeout /t 5