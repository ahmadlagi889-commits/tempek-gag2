@echo off
cd /d "%~dp0"
set /p TOKEN="Paste GitHub token: "
git init
git checkout -b main 2>nul
git config user.name "ahmadlagi889-commits"
git config user.email "ahmadlagi889@gmail.com"
git remote remove origin 2>nul
git remote add origin https://ahmadlagi889-commits:%TOKEN%@github.com/ahmadlagi889-commits/tempek-gag2.git
git add -A
git commit -m "refactor: flat repo structure + vararg fix"
git push --force origin main
echo.
echo Done! Files at: https://github.com/ahmadlagi889-commits/tempek-gag2
pause
