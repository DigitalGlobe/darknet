@echo off
setlocal enableextensions enabledelayedexpansion
call :getargc argc %*
IF /I "%argc%" NEQ "5" (
  ECHO "Usage: darknet.bat <data> <config> <weights> <input_dir> <output_dir>"
  goto :eof
)
FOR %%f IN (%4\*.jpg) DO (
  ECHO %%~nxf
  darknet.exe detector test %1 %2 %3 %%f -out %5%%~nxf.detections -i 0 -thresh 0.25 >%5%%~nxf.detections.txt 2>NUL
REM  ECHO "darknet.exe detector test %1 %2 %3 %%f -out %5%%~nxf.detections > %5%%~nxf.detections.txt 2>NUL"
)
goto :eof
:getargc
    set getargc_v0=%1
    set /a "%getargc_v0% = 0"
:getargc_l0
    if not x%2x==xx (
        shift
        set /a "%getargc_v0% = %getargc_v0% + 1"
        goto :getargc_l0
    )
    set getargc_v0=
    goto :eof

