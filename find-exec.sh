#!/usr/bin/env bash
#Variables
sourceFolder="$PWD"
#Run Chunk
read -p "Where did you install pentools?  " runFolder
echo "Finding executable files  in $runFolder and printing them to files.executable in $sourceFolder"
find $runFolder -type f -executable ! -name '*.c' ! -name '*.h' ! -name '*.cs' ! -name '*.cpp' ! -name '*.sample' ! -name '[Mm]akefile' ! -name '*.gcc'  > $sourceFolder/files.executable
