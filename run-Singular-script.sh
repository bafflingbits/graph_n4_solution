#!/bin/bash

#SINGULAR=Singular  # use installed version
#SINGULAR=./latest/bin/Singular  # use latest release tgz
SINGULAR=./Singular/Singular/Singular  # use built from github
TIME=/usr/bin/time # do not use shell builtin

if [[ "$#" != "1" ]]; then
  echo "Usage:  run-Singular-script.sh file.s"
  echo "will run script with Singular, saving results to out_<file>.txt"
  exit 1
fi
fname="$1"
outname="out_${fname%.*}.txt"

echo "Saving results in: $outname"
echo "+ $SINGULAR -q -e 2>&1 < \"$fname\"" | tee "$outname"
$TIME -f "max memory(KB):%M  time(sec):%e = %E" \
    $SINGULAR -q -e 2>&1 < "$fname" | tee -a "$outname"

