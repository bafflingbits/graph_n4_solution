#!/usr/bin/env python3

import os
import sys
import re

if len(sys.argv) != 2:
    print('Usage: extract_for_mathematica.py out_lift.txt')
    print('  Takes "out_lift.txt" (the output of a Singular lift)')
    print('  and generates "verify_lift.m" in the current directory')
    print('  for checking the result with mathematica.')
    print('This assumes the lift script matches a simple template,')
    print('so this will not work for all script output.')
fname = sys.argv[1]


dirpart, filepart = os.path.split(fname)
base, ext = os.path.splitext(filepart)
if base.startswith("out_"):
    outname = f"verify_{base[4:]}.m"
else:
    outname = f"verify_{base}.m"


I = []
coeff = []
subI = ""
linenum = 0
with open(fname, "r") as f:
    # search for ideal def
    for line in f:
        linenum += 1
        if " ideal I =" in line:
            break
    else:
        print("ERR: early end of file, searching for ideal def")
        sys.exit(1)

    # while ideal polynomials, collect
    for line in f:
        linenum += 1
        # empty
        m = re.fullmatch(r'^[^.]*\.[ ]*(//.*)?\n$', line)
        if m:
            continue
        # contains one polynomial
        m = re.fullmatch(r'^[^.]*\.([^,;]*)([,;])[ ]*(//.*)?\n$', line)
        if not m:
            print(f"ERR: could not parse, line {linenum}: {line!r}")
            sys.exit(1)
        I.append(m.group(1))
        if m.group(2) == ";":
            break
    else:
        print("ERR: early end of file, collecting ideal polynomials")
        sys.exit(1)

    # search for subI def
    for line in f:
        linenum += 1
        m = re.fullmatch(r'^.* ideal subI = ideal\(([^)]*)\);[ ]*(//.*)?\n$', line)
        if not m:
            continue
        subI = m.group(1)
        break
    else:
        print("ERR: early end of file, searching for subI def")
        sys.exit(1)

    # search/collect coeff entry
    indef = 0
    for line in f:
        linenum += 1
        # contains one polynomial
        m = re.fullmatch(r'^T2\[[^\]]*\]=(.*)\n$', line)
        if m:
            if indef == 0:
                indef = 1
                #print(f"Coeff start on line {linenum}")
            coeff.append(m.group(1))
        elif indef:
            #print(f"Coeff end on line {linenum}")
            break
    else:
        print("ERR: early end of file, search/collect coeff entry")
        sys.exit(1)


#print(f"len(I)={len(I)}")
#print(f"len(coeff)={len(coeff)}")
if len(I) != len(coeff):
    print(f"ERR: len(I)={len(I)} but len(coeff)={len(coeff)}")
    sys.exit(1)

print(f"Writing to {outname}")
with open(outname, "w") as f:
    f.write("\n")
    f.write("ideal = {\n")
    f.write("    " + ",\n".join(I) + "};\n")
    f.write("coeff = {\n")
    f.write("    " + ",\n".join(coeff) + "};\n")
    f.write("subI = " +  subI + ";\n")
    f.write("\n")
    f.write("out = Simplify[Expand[ideal.coeff]];\n")
    f.write("Print[\"out = \", out];\n")
    f.write("Print[If[out == subI, \"SUCCESS: passed verification\", \"ERROR: verification failed\"]];\n")


