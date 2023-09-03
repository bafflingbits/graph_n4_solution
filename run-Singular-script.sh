#!/bin/bash

SINGULAR=./Singular/Singular/Singular  # use built from github
TIME=/usr/bin/time # do not use shell builtin

if [[ "$#" != "1" ]]; then
  echo "Usage:  run-Singular-script.sh file.s"
  echo "will run script with Singular, saving results to out_<file>.txt"
  exit 1
fi
fname="$1"

dirpart=$(dirname "$fname")
filepart=$(basename "$fname")
outname="$dirpart/out_${filepart%.*}.txt"
echo "Saving results in: $outname"

# use full path to Singular, in case script is invoked from another directory
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
SINGULAR_FULLPATH=$(readlink -f "$SCRIPT_DIR/$SINGULAR")

SINGULAR_OPTIONS="-q --no-rc -e"
echo "+ $SINGULAR $SINGULAR_OPTIONS 2>&1 < \"$fname\"" | tee "$outname"
$TIME -f "max memory(KB):%M  time(sec):%e = %E" \
    $SINGULAR_FULLPATH $SINGULAR_OPTIONS 2>&1 < "$fname" | tee -a "$outname"

