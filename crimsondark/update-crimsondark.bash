#!/bin/bash
cd /home/doug/webcomic/crimsondark
wget "http://www.davidcsimon.com/crimsondark/index.php?view=archive" -q -O archive.html
touch downloaded.log
archs=`cat archive.html`
arglist=`for a in $archs; do echo $a | grep "http://www.davidcsimon.com/crimsondark/index.php?view=comic&strip_id=.*\"" --only-matching | sed 's/\"$//'; done`
for arg in $arglist
do
    if [ "`grep $arg\$ downloaded.log`" == "" ]
    then
        wget "$arg" -q -O cur.html
	img=`grep "istrip_files/strips/.*\.jpg" cur.html --only-matching`
        wget http://www.davidcsimon.com/crimsondark/$img -q
	echo $arg >> downloaded.log
        rm cur.html
	sleep 3
    fi
done
rm archive.html
