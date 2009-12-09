#!/bin/bash
cd /home/doug/webcomic/whatbirdsknow
wget http://fribergthorelli.com/wbk/index.php/comic-archive/ -q -O archive.html
touch downloaded.log
for arg in `grep "wbk/index\.php/page.[^\"]*" archive.html --only-matching`
do
    if [ "`grep $arg downloaded.log`" == "" ]
    then
	wget http://fribergthorelli.karrey.com/$arg -q -O cur.html
	img=`grep "http://fribergthorelli.com/wbk/comics/.*\.jpg" cur.html --only-matching`
	echo $arg >> downloaded.log
	wget -q "$img"
	rm cur.html
    fi
done
rm archive.html
