#!/bin/bash
cd /home/doug/webcomic/phoenixrequiem
wget http://requiem.seraph-inn.com/archives.html -q -O archive.html
touch downloaded.log
archs=`cat archive.html`
arglist=`for a in $archs; do echo $a | grep "viewcomic\.php?page=.*\"" --only-matching | sed 's/\"$//'; done`
for arg in $arglist
do
    if [ "`grep $arg downloaded.log`" == "" ]
    then
        wget http://requiem.seraph-inn.com/$arg -q -O cur.html
	img=`grep "pages/.*\.jpg" cur.html --only-matching`
        wget http://requiem.seraph-inn.com/$img -q
	echo $arg >> downloaded.log
        rm cur.html
    fi
done
rm archive.html
