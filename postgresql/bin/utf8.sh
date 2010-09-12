OUT=$(pwd)/../traduzione

cd $OUT

for f in $(find . -type f -name "*.xml")
do
	echo $f
	iconv -f latin1 -t utf-8 $f > $f.new
	mv $f.new $f
done
