:start
@echo on
@SET /P test_case_num=Type the test case number (01~17): 
@echo Execute TC-%test_case_num%
@echo.
@echo off
call robot -d Output ./Tests/TC-%test_case_num%*
@echo.
goto start
