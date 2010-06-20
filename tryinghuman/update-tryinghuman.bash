#!/bin/bash
cd /home/doug/webcomic/tryinghuman
wget "http://www.tryinghuman.com/index.php?view=archives" -q -O archive.html
touch downloaded.log
archs=`cat archive.html`
arglist=`for a in $archs; do echo $a | grep "http://www.tryinghuman.com/comic.php?strip_id=[^\"]*" --only-matching; done`
for arg in $arglist
do
    if [ "`grep $arg\$ downloaded.log`" == "" ]
    then
        wget "$arg" -q -O cur.html
	img=`grep "istrip_files/strips/.*\.jpg" cur.html --only-matching`
        wget "http://www.tryinghuman.com/$img" -q
	echo "$arg" >> downloaded.log
        rm cur.html
    fi
done
rm archive.html
