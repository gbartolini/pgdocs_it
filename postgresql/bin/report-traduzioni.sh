#!/bin/bash

TRADUZIONI=$(pwd)/../traduzione

cd $TRADUZIONI

for i in $( find . -type f -name '*.xml' | sed -e 's/^\.\///' )
do
	n=$(wc -l $i | cut -f 1 -d ' ')
	echo $i"|"$n"|"$(stat -c%s $i)
done
