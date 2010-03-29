#!/bin/bash
# Script used for the initial download of digger.

touch downloaded.log
wget -q http://www.diggercomic.com/ -O main.html
for month in `grep "http://www.diggercomic.com/?m=.[^']*'" main.html --only-matching | sed "s/'$//"`
do
    wget "$month" -q -O month.html
    hasmore=`grep "pagenav-right" month.html`
    while [ -n "$hasmore" ]
    do
	echo "has more pages"
	for comicpage in `grep "http://www.diggercomic.com/?p=.[^\"]*" month.html --only-matching`
	do
	    echo "examining $comicpage"
	    if [ "`grep $comicpage downloaded.log`" == "" ]
	    then
		echo $comicpage
		wget "$comicpage" -q -O comicpage.html
		img=`grep "http://www.diggercomic.com/comics/.[^\"]*" comicpage.html --only-matching`
		echo "download image $img"
		wget -q "$img"
		echo "$comicpage" >> downloaded.log
		sleep $(($RANDOM % 10))
	    else
		echo "skipping $comicpage"
	    fi
	done
	hasmore=`grep "pagenav-right" month.html`
	nextdownload=`echo $hasmore | grep 'http.[^"]*' --only-matching | sed 's/\&#038;/\&/'`
	echo "downloading $nextdownload"
	wget "$nextdownload" -O month.html
    done
done
