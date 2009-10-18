#!/bin/bash
cd /home/doug/webcomic/girlgenius
wget -q http://www.girlgeniusonline.com/ggmain.rss -O feed.rss
touch downloaded.log
for arg in `cat feed.rss | grep "<link>.*</link>" --only-matching | sed 's/<link>//' | sed 's/<\/link>//'`
do
    if [ "`grep $arg downloaded.log`" == "" ]
    then
	wget $arg -q -O cur.html
	img=`grep "http://www.girlgeniusonline.com/ggmain/strips/ggmain.*\.jpg" cur.html --only-matching`
	wget $img -q
	echo $arg >> downloaded.log
	rm cur.html
    fi
done
rm feed.rss
