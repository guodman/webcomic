#!/bin/bash
cd /home/doug/webcomic/whatbirdsknow
wget http://fribergthorelli.karrey.com/wbk/comicarchive.htm -q -O archive.html
touch downloaded.log
for arg in `grep "wbk.*\.htm" archive.html --only-matching`
do
    if [ "`grep $arg downloaded.log`" == "" ]
    then
	wget http://fribergthorelli.karrey.com/wbk/$arg -q -O cur.html
	img=`grep "\"p.*jpg" cur.html --only-matching | sed 's/^\"//'`
	echo $arg >> downloaded.log
	wget -q "http://fribergthorelli.karrey.com/wbk/$img"
	rm cur.html
    fi
done
rm archive.html
