#!/bin/bash
cd /home/doug/webcomic/gunnerkriggcourt
wget -q http://www.gunnerkrigg.com/archive.php -O archive.php
touch downloaded.log
for arg in `grep http://www.gunnerkrigg.com/archive_page.php?comicID=.[^\"]*\" archive.php --only-matching`
do
    if [ "`grep "$arg" downloaded.log`" == "" ]
    then
	down=`echo $arg | sed 's/"$//'`
	wget $down -q -O cur.html
	img=`grep "http://www.gunnerkrigg.com//comics/.*\.jpg" cur.html --only-matching`
	wget -q "$img"
	echo "$arg" >> downloaded.log
	rm cur.html
    fi
done
rm archive.php
