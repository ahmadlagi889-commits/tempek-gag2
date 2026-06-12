#!/bin/bash
# Push GAG Hub to GitHub
# Usage: bash push.sh YOUR_TOKEN

cd "$(dirname "$0")"
git init && git checkout -b main 2>/dev/null
git config user.name "ahmadlagi889-commits"
git config user.email "ahmadlagi889@gmail.com"
git remote remove origin 2>/dev/null
git remote add origin "https://ahmadlagi889-commits:$1@github.com/ahmadlagi889-commits/tempek-gag2.git"
git add -A && git commit -m "refactor: flat repo structure + vararg fix"
git push --force origin main
