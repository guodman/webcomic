#!/bin/bash
cd /home/doug/webcomic/digger
wget "http://www.diggercomic.com/?feed=rss2" -q -O comic.rss
touch downloaded.log
for arg in `grep "http://www.diggercomic.com/?p=.[^\"^<^#]*" comic.rss --only-matching | sort --uniq`
do
    if [ "`grep $arg downloaded.log`" == "" ]
    then
	wget "$arg" -q -O cur.html
	img=`grep "http://www.diggercomic.com/comics/.*gif" cur.html --only-matching`
	wget -q "$img"
	echo $arg >> downloaded.log
	rm cur.html
    fi
done
rm comic.rss
