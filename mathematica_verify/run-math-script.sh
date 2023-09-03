#!/bin/bash

TIME=/usr/bin/time # do not use shell builtin
MATH=math # assume Mathematica available via path

if [[ "$#" != "1" ]]; then
  echo "Usage:  run-math-script.sh script.m"
  echo "will run script with Mathematica, saving results to out_<file>.txt"
  exit 1
fi
fname="$1"

fdir=$(dirname -- "$fname")
fbase=$(basename -- "$fname")
outname="$fdir/out_${fbase%.*}.txt"
echo "Saving results in: $outname"

CMD="$MATH -script"
echo "+ $CMD \"$fname\" 2>&1" | tee "$outname"
$TIME -f "max memory(KB):%M  time(sec):%e = %E" \
    $CMD "$fname" 2>&1 | tee -a "$outname"

