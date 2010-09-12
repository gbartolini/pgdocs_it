IN=${HOME}/src/postgres/postgresql/doc/src/sgml
OUT=$(pwd)/../base
FIX=$(pwd)/fix_sgml.php

if [ ! -d $OUT/ref ]
then
	mkdir $OUT/ref
fi

cd $IN
for sgml in $(find . -name "*.sgml")
do

	xml=$(echo $sgml | sed -e 's/\.sgml/\.xml/')
	echo "$sgml -> $xml"
	if [ -f ${sgml} ]
	then
		$FIX ${sgml} | iconv -f LATIN1 -t UTF-8 > ${OUT}/${xml}
	fi
done

SGMLLIST="filelist.xml postgres.xml ref/allfiles.xml standalone-install.xml"
for f in $(echo $SGMLLIST)
do
	echo "Cambio riferimento SGML in $f"
	sed -e 's/\.sgml/\.xml/' -e 's/<!entity/<!ENTITY/' $OUT/$f > $OUT/$f.new
	mv $OUT/$f.new $OUT/$f
done
