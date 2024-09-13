#!/bin/bash
# LVCompare.sh - A script for comparing two LabVIEW files using the LabVIEW Compare tool.
# Author: Alonso Cifuentes
# Date: 13/09/2024
# Version: 2
#
# Description: This script calculates the absolute Windows-compatible paths for two 
# given files (local and remote), converts the paths to the correct format for Windows, 
# and executes LVCompare.exe to compare them. The -nobdpos and -nofppos options are 
# used to ignore differences in block diagram positions and front panel positions.
# The -W parameter on the pwd command is necessary to return the Windows version of the path.
# Not using the -W parameter will result in a conversion of temp directory to a 'tmp' path meaningful only in the Linux environment.
# Piping the result through tr '/' '' translates the forward slashes to backslashes.
# Windows understands forward slashes, but LVCompare.exe does not.
# 
# Usage (w/ git bash): 
# git difftool HEAD^ HEAD <file.vi>
# Secondary Usage: ./LVCompare.sh <local_file> <remote_file>
#---------------------------------------------------------------------------------------------------------
abspath () {
  DIR=$(dirname "$1")
  FN=$(basename "$1")
  cd "$DIR" || exit
  printf "%s\\%s" "$(pwd -W)" "$FN" | tr '/' '\\'
}
lvcompare="C:/Program Files (x86)/National Instruments/Shared/LabVIEW Compare/LVCompare.exe"
local=$(abspath "$1")
remote=$(abspath "$2")
# Output the paths for debugging purposes
echo "Local: $local"
echo "Remote: $remote"
# Execute LVCompare with the correct 
# "$lvcompare" -nobdpos -nofppos "$local" "$remote" # <- original
"$lvcompare" "$local" "$remote" -nobdpos -nofppos
