#!/usr/bin/python2
# -.- coding: utf-8 -.-

# Create the cross-product (full join) of the 2 specified files

import sys, os

######################

filea = sys.argv[1]
fileb = sys.argv[2]

if __name__ == '__main__':
    with open(filea, 'r') as f:
        left = [x.rstrip("\r\n") for x in f] 

    with open(fileb, 'r') as f:
        right = [x.rstrip("\r\n") for x in f] 

    for l in left:
        for r in right:
            print "%s\t%s" % (l, r)

