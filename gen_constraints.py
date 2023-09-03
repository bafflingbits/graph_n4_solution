#!/usr/bin/env python3

import sys
import itertools

if len(sys.argv) < 3:
    print("Usage: gen_constraints.py numNodes numColors")
    sys.exit(1)
numNodes = int(sys.argv[1])
numColors = int(sys.argv[2])


def perfectMatchings(n):
    """
    calculate all perfect matchings on K_n
    returns list of matchings: list of edges: tuple of node numbers
    """
    if n%2 != 0:
        raise ValueError("number of nodes should be even")
    matchings = _perfectMatchings(range(n))
    matchings.sort()
    return matchings

def _perfectMatchings(nodelist):
    """recursively find perfect matchings on remaining nodes"""
    # base case, only two nodes left
    if len(nodelist) == 2:
        return [[tuple(nodelist),],]

    matchings = []
    # loop over ways to match first node with other nodes
    for n in nodelist[1:]:
        mStart = [(nodelist[0],n),]
        # get list of what nodes are left to match
        nextlist = list(nodelist[1:])
        nextlist.remove(n)
        # recursively find all the matchings of remaining nodes
        # and combine with our starting match choice
        for mSubgraph in _perfectMatchings(nextlist):
            mCombined = list(mStart)
            mCombined.extend(mSubgraph)
            matchings.append(mCombined)
    return matchings


def weightName(n1, n2, c1, c2):
    return "w{}{}{}{}".format(n1,n2,c1,c2)

def allVariables(nNodes,nColors):
    vlist = []
    for n1 in range(nNodes):
        for n2 in range(n1+1,nNodes):
            for c1 in range(nColors):
                for c2 in range(nColors):
                    vlist.append(weightName(n1,n2,c1,c2))
    return vlist

def constraintTerm(matching, colorList):
    vlist = []
    for n1,n2 in matching:
        vlist.append(weightName(n1, n2, colorList[n1], colorList[n2]))
    return "*".join(vlist)

def colorConstraint(matchingList, colorList):
    tlist = []
    for m in matchingList:
        tlist.append(constraintTerm(m, colorList))
    poly = " + ".join(tlist)
    if all(c == colorList[0] for c in colorList):
        poly += " - 1"
    return poly

def allConstraints(nNodes,nColors):
    matchingList = perfectMatchings(nNodes)
    plist = []
    for clist in itertools.product(range(nColors), repeat=nNodes):
        plist.append(colorConstraint(matchingList, clist))
    return plist


vlist = allVariables(numNodes, numColors)
plist = allConstraints(numNodes, numColors)

print("// n={} c={}".format(numNodes, numColors))
print("// total variables:", len(vlist))
print("// total constraints:", len(plist))

group = numColors*numColors
pieces = [", ".join(vlist[x:x+group]) for x in range(0,len(vlist),group)]
print("ring R = QQ[\n    " + ",\n    ".join(pieces) + "];")
print("ideal I =\n  " + ",\n  ".join(plist) + ";")
print("option(redSB);\n"
      "option(prot);\n"
      "ideal I2 = slimgb(I);\n"
      "I2;")

