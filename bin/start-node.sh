#!/bin/bash

HAZELCAST_FILE=hazelcast.xml
HAZELCAST_CONFIG_FILE=/opt/hazelcast/$HAZELCAST_FILE

echo Check if hazelcast configuration file exists...
if [ -f $HAZELCAST_CONFIG_FILE ]; then
	echo $HAZELCAST_CONFIG_FILE exists
else
	echo $HAZELCAST_CONFIG_FILE does not exist. Wait for it.
	inotifywait -m /opt/hazelcast -e create |
		while read path action file; do
			echo "The file '$file' appeared in directory '$path' via '$action'"
			if [ $file == $HAZELCAST_FILE ]; then
				echo "Start hazelcast node..."
				java -server -Dhazelcast.config=/opt/hazelcast/hazelcast.xml com.hazelcast.core.server.StartServer
			fi
		done
fi
