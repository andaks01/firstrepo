#!/bin/bash

w=` | grep pairId`
sleep 2
#second change git
w=``
if [ -z $w ];then
	echo 1
	echo `date`$w >> /.andaks/scripts/exc/error_contents.log
#> /.andaks/scripts/exc/api.log
else
	echo 0
# > /.andaks/scripts/exc/api.log
fi
##third git commit
# moving to newly created brach developing
