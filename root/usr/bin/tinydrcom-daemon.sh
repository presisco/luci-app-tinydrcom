#!/bin/sh /etc/rc.common
#tinydrcom daemon
#Author:presisco

DAEMONCOUNT=`ps | grep -c tinydrcom-daemon`
DLOGPATH=$(uci get tinydrcom.@tinydrcom[0].dlogpath)
EZLOGPATH=$(uci get tinydrcom.@tinydrcom[0].ezlogpath)
DLOGMAXSIZE=$(uci get tinydrcom.@tinydrcom[0].dlogsize)
EZLOGMAXSIZE=$(uci get tinydrcom.@tinydrcom[0].ezlogsize)
INTERVAL=$(uci get tinydrcom.@tinydrcom[0].dinterval)
let "DLOGMAXSIZE*=1024"
let "EZLOGMAXSIZE*=1024"

if [ $DAEMONCOUNT -ge "4" ]
then
	exit 0
else
	DATE=`date`
	echo "tinydrcom daemon started at $DATE">>$DLOGPATH
	echo "max tinydrcom log size:$EZLOGMAXSIZE">>$DLOGPATH
	echo "max daemon log size:$DLOGMAXSIZE">>$DLOGPATH
	echo "check interval:$INTERVAL">>$DLOGPATH

	while true
	do
		sleep $INTERVAL
		
		EZLOGSIZE=`awk 'END{print NR}' $EZLOGPATH`
		if [ $EZLOGSIZE -gt $EZLOGMAXSIZE ]
		then
			echo "" > $EZLOGPATH
			DATE=`date`
			echo "cleared tinydrcom logfile at $DATE">>$DLOGPATH
		fi
		
		DLOGSIZE=`awk 'END{print NR}' $DLOGPATH`
		if [ $DLOGSIZE -gt $DLOGMAXSIZE ]
		then
			echo "" > $DLOGPATH
		fi
		
		PCOUNT=`ps | grep -c "tinydrcom -b -r"`
		DATE=`date`
		if [ $PCOUNT -lt "2" ]
		then
			echo "tinydrcom restarted at $DATE">>$DLOGPATH
			/etc/init.d/tinydrcom-conf start
		fi
	done
fi