@echo off
:: Change directory to the project folder
cd /d "D:\code\chrome-devtools-power"

:: Initialize Git if it hasn't been already
if not exist .git (
    echo Initializing Git...
    git init
)

:: Add all files to the staging area
echo Adding files...
git add .

:: Create the initial commit
set /p commit_msg="Enter commit message (or press Enter for 'Initial commit'): "
if "%commit_msg%"=="" set commit_msg=Initial commit
git commit -m "%commit_msg%"

:: Rename branch to main (standard for GitHub)
git branch -M main

:: Add the remote origin if it doesn't exist
git remote remove origin >nul 2>&1
git remote add origin https://github.com/kalingaCoder/chrome-dev-tools.git

:: Push to the repository
echo Pushing to GitHub...
git push -u origin main

echo Done!
pause