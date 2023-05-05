#!/bin/bash

grep -rc "$@" . | sed -e '/:0$/d' -e '/\/\.\(svn\|git\|hg\)\//d' -e '/\.\(pyc\|dll\|exe\|pdb\):[1-9][0-9]*$/d' -e '/^\..*\.sw[nop]:[1-9][0-9]*$/d' -e '/^\.sw[nop]:[1-9][0-9]*$/d' -e '/\/bin\/\(Debug\|Release\)\//d' -e '/\/node_modules\//d'
