#!/bin/bash

XSL=$(pwd)/../stylesheets
XSLROOTDIR=$(echo $1 | sed -e 's/\//\\\//g')
echo $XSLROOTDIR

for filename in $(find $XSL -name "*.xsl.in" | sed -e 's/\.in$//')
do
	echo $filename;
	sed -e "s/@XSLROOTDIR@/${XSLROOTDIR}/g" $filename.in > $filename
done
