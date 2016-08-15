#!/bin/sh

for i in `seq 1 30`;
do
	sudo ./btrbk -c ./btrbk_simulation.conf -t $i.09.2015 dryrun
	if [ $? -ne 0 ]; then
		exit $?
	fi
done
