#!/bin/bash
cd /home/doug/webcomic/dreamless
wget http://dreamless.keenspot.com/comic.rss -q -O comic.rss
touch downloaded.log
for arg in `grep "http://dreamless.keenspot.com/d/.*\.html" comic.rss --only-matching`
do
    if [ "`grep $arg downloaded.log`" == "" ]
    then
	wget $arg -q -O cur.html
	img=`grep "/comics/dreamless.*jpg" cur.html --only-matching`
	wget -q "http://dreamless.keenspot.com$img"
	echo $arg >> downloaded.log
	rm cur.html
    fi
done
rm comic.rss
