@echo off
echo .........................................
echo ................Quick App................
echo .........................................
echo.
echo.
echo by Akshay Gaonkar (paradox)
echo.
echo.
echo Step 1:-
echo.
echo Export ur Construct 2 project as HTML 5 website
echo.
echo Done?
pause
cls
echo.
echo.
echo Step 2:-
echo.
echo Open ur export folder , and copy every thing in it ,
echo and paste in the 'assets' folder given
echo.
echo Done?
pause
cls
echo.
echo.
echo Step 3:-
echo.
set /p n=Enter Your App Name:
echo MAKING %n%-Quick_App.apk , WAIT !
echo Loading.....
echo.

copy data.apk %n%-Quick_App.apk

7za a -tzip %n%-Quick_App.apk assets/*

Sign.cmd %n%-Quick_App.apk
echo ...

