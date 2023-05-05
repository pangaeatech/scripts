#!/usr/bin/python2

import json, dict2xml, sys

if len(sys.argv) < 2:
    print "Usage: %s JSON_FILE > XML_FILE" % sys.argv[0]
    sys.exit(1)

with file(sys.argv[1]) as f:
    s = f.read()
t = json.loads(s)
x = dict2xml.dict2xml(t)
print x
