FROM java:7-jre
ENV HZ_VERSION 3.7.1
ENV HZ_HOME /opt/hazelcast/

RUN set -x && \
    apt-get update && \
    apt-get install -y wget curl vim && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p $HZ_HOME

WORKDIR $HZ_HOME

# Download hazelcast jars from maven repo.
ADD https://repo1.maven.org/maven2/com/hazelcast/hazelcast-all/$HZ_VERSION/hazelcast-all-$HZ_VERSION.jar $HZ_HOME
ADD server.sh /$HZ_HOME/server.sh
ADD stop.sh /$HZ_HOME/stop.sh
RUN chmod +x /$HZ_HOME/server.sh && \
	chmod +x /$HZ_HOME/stop.sh

# Start hazelcast standalone server.
CMD ./$HZ_HOME/server.sh
EXPOSE 5701