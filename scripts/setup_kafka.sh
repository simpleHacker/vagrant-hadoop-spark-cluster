#!/bin/bash
source "/vagrant/scripts/common.sh"

function installRemoteKafka {
    echo "install spark from remote file"
    curl -o /vagrant/resources/$KAFKA_ARCHIVE -O -L $KAFKA_MIRROR_DOWNLOAD
    tar -xzf /vagrant/resources/$KAFKA_ARCHIVE -C /usr/local
}

function installLocalKafka {
  echo "install kafka from local file"
  FILE=/vagrant/resources/$KAFKA_ARCHIVE
  tar -xzf $FILE -C /usr/local
}

function installKafka {
  if resourceExists $KAFKA_ARCHIVE; then
    installLocalKafka
  else
    installRemoteKafka
  fi
  ln -s /usr/local/$KAFKA_VERSION /usr/local/kafka
}	

function setupEnvVars {
  echo "creating kafka environment variables"
  export PATH=/usr/local/kafka/bin:${PATH}
}

function setupConfig {
  echo "install zookeeper and server config"
  ZOOKEEPER_CONFIG=zookeeper.properties
  ZOOKEEPER_FILE=/vagrant/resources/kafka/zookeeper.properties
  SERVER_CONFIG=server.properties
  SERVER_FILE=/vagrant/resources/kafka/$SERVER_CONFIG
  cp -f $ZOOKEEPER_FILE /usr/local/kafka/config
  cp -f $SERVER_FILE.$1 /usr/local/kafka/config
}

echo "setup kafka for $1" 
installKafka
setupConfig $1
setupEnvVars
