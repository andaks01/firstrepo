#!/bin/bash
# Script name: cpuload.sh
# Author ....: Marco Lucena (marcolucena@...)
#----------
# SAMPLES ARE STORED HERE
# For the first time, these both files should not exist.
#----------
CPUOLD=/var/tmp/cpuloadvalue.old
CPULAST=/var/tmp/cpuloadvalue.last
#----------
if [ -f $CPULAST ]
then
   FLAG_INICIO="NO"
else
   FLAG_INICIO="YES"
fi
if [ "$FLAG_INICIO" = "NO" ]
then
   cat $CPULAST >$CPUOLD
fi
cat /proc/stat|grep "cpu "|awk '{print $2+$3+$4":"$5}' >$CPULAST
if [ "$FLAG_INICIO" = "YES" ]
then
   cat $CPULAST >$CPUOLD
fi
BUSY_OLD=`cat $CPUOLD|cut -f1 -d":"`
BUSY_LAST=`cat $CPULAST| cut -f1 -d":"`
IDLE_OLD=`cat $CPUOLD|cut -f2 -d":"`
IDLE_LAST=`cat $CPULAST|cut -f2 -d":"`
BUSY_DELTA=`echo $BUSY_OLD $BUSY_LAST|awk '{print $2-$1}'`
IDLE_DELTA=`echo $IDLE_OLD $IDLE_LAST|awk '{print $2-$1}'`
TOTAL=`echo $BUSY_DELTA $IDLE_DELTA|awk '{print $1+$2}'`
if [ "$FLAG_INICIO" = "YES" ]
then
   echo "0"
   exit
fi
BUSY_PCT=`echo $BUSY_DELTA $TOTAL|awk '{print ($1/$2)*100}'`
IDLE_PCT=`echo $BUSY_PCT|awk '{print 100-$1}'`
case "$1" in
   0)
     echo $BUSY_PCT
     ;;
   1)
     echo $IDLE_PCT
     ;;
   *)
     echo "0"
     ;;
esac
exit
