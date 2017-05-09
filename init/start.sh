#!/bin/sh

# start fluentd and monitor resource consumption
fluentd -c /fluentd/etc/fluent.conf -p /fluentd/plugins &

# start monitoring fluentd fluentd runs in two processes
# one process keeps the same PID the other process 
# starts/restarts resulting in different PIDS this script
# grabs both running processes and adds the numbers together 
while [ 1 ]; do
	CPU_TOTAL=0.0
	MEM_TOTAL=0

	PIDS=`ps -ef | grep fluentd | grep -v grep | awk '{print $2}'`
	for i in $PIDS
		do
		CPU=$(ps -p $i -o %cpu=)
		MEM=$(ps -p $i -o vsz=)
		# sh can't add decimals, use ruby
		CPU_TOTAL=`ruby -e "print $CPU + $CPU_TOTAL"`
		MEM_TOTAL=$(($MEM+$MEM_TOTAL))
	done

	echo "[metrics]: $CPU_TOTAL $MEM_TOTAL"
sleep 2
done
