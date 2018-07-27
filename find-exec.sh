#!/usr/bin/env bash
sourceFolder="$PWD"
read -p "Where did you install pentools?  " runFolder
echo "Finding executable files  in $runFolder and printing them to files.executable in $sourceFolder"
find $runFolder -type f -executable > $sourceFolder/files.executable
