@ECHO OFF
if "%1"=="" goto usage
cd /d "%~dp0"
echo.
echo  Signing...
echo.

:getfile
if "%1"=="" goto alldone
java -jar signapk.jar testkey.x509.pem testkey.pk8 "%1" "%~dpn1.signed%~x1"
if errorlevel 1 goto error
echo    %~nx1 - complete
del %~nx1
shift
goto getfile

:error
echo.
echo  !!!Aborted!!!
goto end

:usage
echo.
echo  How to use this file:
echo   Drop file(s) on this file, or type "%~nx0 "D:\full\path\to\file1.ext" "D:\full\path\to\file2.ext" ..."
goto end 

:alldone
echo.
echo  All done!

:end
echo.
pause