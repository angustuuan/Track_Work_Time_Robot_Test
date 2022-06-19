:start
@echo on
@SET /P test_suite_num=Type the test suite number (01~13): 
@echo Execute TS-%test_suite_num%
@echo.
@echo off
call robot -d Output ./Tests/TS-%test_suite_num%*
@echo.
goto start
