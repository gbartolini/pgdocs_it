IN=$(pwd)/../base
OUT=$(pwd)/../traduzione

if [ ! -d $OUT/ref ]
then
	mkdir $OUT/ref
fi

cp $IN/*.xml $OUT
cp $IN/ref/*.xml $OUT/ref
