#!/bin/bash
source "/vagrant/scripts/common.sh"

function installRemoteKafka {
    echo "install spark from remote file"
    KAFKA_MIRROR_DOWNLOAD=../resources/kafka/$KAFKA_ARCH
    curl -o /vagrant/resources/$KAFKA_ARCHIVE -O -L $KAFKA_MIRROR_DOWNLOAD
    tar -xzf /vagrant/resources/$KAFKA_ARCHIVE -C /usr/local
}

function installKafka {
  echo "install kafka from local file"
  [[ -z ${KAFKA_VERSION// } ]] && KAFKA_VERSION=kafka_2.11-0.10.2.0
  [[ -z ${KAFKA_ARCHIVE// } ]] && KAFKA_ARCHIVE=$KAFKA_VERSION.tgz
  FILE=/vagrant/resources/$KAFKA_ARCHIVE
  tar -xzf $FILE -C /usr/local
  ln -s /usr/local/$KAFKA_VERSION /usr/local/kafka
}



function setupEnvVars {
  echo "creating kafka environment variables"
  export PATH=/usr/local/kafka/bin:${PATH}
}

function installConfig {
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
installConfig $1
setupEnvVars
