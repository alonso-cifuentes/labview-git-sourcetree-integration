#!/bin/bash
# LVMerge.sh - A script to assist in merging LabVIEW files using the LabVIEW Merge tool.
# Author: Alonso Cifuentes
# Date: 13/09/2024
# Version: 2
#
# Description: This script takes four file arguments (base, remote, local, and merged versions)
# and copies them to the current working directory as temporary files. It prepares them for merging 
# by adjusting path formats and launching the LabVIEW Merge tool (LVMerge.exe). Once the merge 
# is completed, the temporary files are removed.
#
# Usage (w/ git bash): 
# < perform edits in a secondary branch >
# < switch to main branch > 
# git merge <secondary branch name>
# git mergetool
# git add .
# git commit -m ""
# git push <origin> <main> 
# Secondary Usage: ./LVMerge.sh <base_file> <remote_file> <local_file> <merged_file>
#---------------------------------------------------------------------------------------------------------
# read -p "Press any key to start the comparison"
echo $1 # Base
echo $2 # Remote (theirs)
echo $3 # Local (yours)
echo $4 # Merged
cp "$1" "$PWD/temp_${1##*/}"    # Moving and renaming the temp file
cp "$2" "$PWD/temp_${2##*/}"    # Moving and renaming the temp file
cp "$3" "$PWD/temp_${3##*/}"    # Moving and renaming the temp file
tgt1=$PWD/temp_${1##*/}         # Setting up the correct value to the tgt1 parameter
tgt2=$PWD/temp_${2##*/}         # Setting up the correct value to the tgt2 parameter
tgt3=$PWD/temp_${3##*/}         # Setting up the correct value to the tgt3 parameter
tgt4=$PWD/$4                    # Setting up the correct value to the tgt4 parameter
# stream edit: (substitute) "/" with "\" (g)lobally (the whole string)
# Extra c\ due to Git running in MINGW32, replace with C:\
tgt1=$(echo ${tgt1} | sed 's/\//\\/g' | sed 's/\\c\\/C:\\/')
tgt2=$(echo ${tgt2} | sed 's/\//\\/g' | sed 's/\\c\\/C:\\/')
tgt3=$(echo ${tgt3} | sed 's/\//\\/g' | sed 's/\\c\\/C:\\/')
tgt4=$(echo ${tgt4} | sed 's/\//\\/g' | sed 's/\\c\\/C:\\/')
echo Launching LVMerge.exe With args:
echo $tgt1
echo $tgt2
echo $tgt3
echo $tgt4  # Names are friendly...
# LVMerge command line
"C:\Program Files (x86)\National Instruments\Shared\LabVIEW Merge\LVMerge.exe" "$tgt1" "$tgt2" "$tgt3" "$tgt4"
rm -rf "$tgt1" "$tgt2" "$tgt3"  #removing unnecessary files