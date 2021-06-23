#!/bin/sh

# JULIO 2020. CÉSAR BORAO: findbig.sh

if test $# -eq 0 || test $# -gt 2
then
	echo [error] usage: findbig [bytes num] [directory] 1>&2
	exit 1;
fi

if test $# -eq 2
then
	dir=$2
else
	dir=$1
fi

if ! test -d $dir
then
	echo error: directory not found 1>&2
	exit 1;
fi

for x in $(du -a -b $dir | sort -n -r | awk '{print $2}')
do
	if test -f $x && (file $x | grep text) > /dev/null
	then
		line=$(du -a -b $dir | sort -n -r |grep $x)

		if test $# -eq 1 || (test $# -eq 2 && test $(echo $line | awk '{print $1}') -ge $1)
		then
			echo $line
		fi
	fi
done
exit 0
