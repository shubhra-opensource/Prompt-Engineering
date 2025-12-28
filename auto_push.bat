@echo off
REM Stages all changes
git add .

REM Gets the current date and formats it as YYYY-MM-DD
for /f "tokens=2 delims==" %%I in ('"wmic os get localdatetime /value"') do set datetime=%%I
set commit_date=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%

REM Commits with the date as the message
git commit -m "%commit_date%"

REM Pushes to the remote repository
git push