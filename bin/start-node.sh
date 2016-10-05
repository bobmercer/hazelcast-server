#!/bin/bash

HAZELCAST_FILE=hazelcast.xml
HAZELCAST_CONFIG_FILE=/opt/hazelcast/$HAZELCAST_FILE

echo Check if hazelcast configuration file exists...
if [ -f $HAZELCAST_CONFIG_FILE ]; then
	echo $HAZELCAST_CONFIG_FILE exists
else
	echo $HAZELCAST_CONFIG_FILE does not exist. Wait for it.
	while [ ! -f "$HAZELCAST_CONFIG_FILE" ]
	do
		# Timeout necessary to prevent a TOCTTOU race condition. Otherwise, inotifywait could hang 
		# indefinitely if a file is created just before it starts listening for events.
		inotifywait -qqt 60 -e create -e moved_to "$(dirname $HAZELCAST_CONFIG_FILE)"
	done
fi

java -server -Dhazelcast.config=/opt/hazelcast/hazelcast.xml com.hazelcast.core.server.StartServer