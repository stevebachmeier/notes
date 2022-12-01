#!/bin/bash

echo "Changing to notes dir"
cd ~/repos/notes/

echo "Syncing notes"
git pull

echo ""
echo "Staging changed files"
git add -A

echo ""
echo "Committing staged files"
git commit -m "Sync - $(date)"

echo ""
echo "Pushing changes to github"
git push

echo ""
echo "Changing back to original dir"
cd -

echo ""
echo "Finished Syncing"
