#!/bin/bash
cd /home/doug/webcomic/clockworks
wget "http://shawntionary.com/clockworks/?page_id=349" -q -O archive.html
touch downloaded.log
archs=`cat archive.html`
arglist=`for a in $archs; do echo $a | grep "http://shawntionary.com/clockworks/?p=[^\"]*" --only-matching; done`
for arg in $arglist
do
    if [ "`grep $arg\$ downloaded.log`" == "" ]
    then
        wget "$arg" -q -O cur.html
	img=`grep "http://shawntionary.com/clockworks/comics/.*\.jpg" cur.html --only-matching`
        wget "$img" -q
	echo "$arg" >> downloaded.log
        rm cur.html
    fi
done
rm archive.html
