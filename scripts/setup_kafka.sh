#!/bin/bash

function installKafka {
  echo "install kafka from local file"
  FILE=/vagrant/resources/kafka/$KAFKA_ARCHIVE
  tar -xzf $FILE -c /usr/local
  ln -s /usr/local/$KAFKA_VERSION /usr/local/kafka
}

function setupEnvVars {
  echo "creating kafka environment variables"
  export PATH=/usr/local/kafka/bin:${PATH}
}

function installConfig {
  echo "install zookeeper and server config"
  ZOOKEEPER_FILE=/vagrant/resources/kafka/zookeeper.properties
  SERVER_CONFIG=server.properties
  SERVER_FILE=/vagrant/resource/kafka/$SERVER_CONFIG
  cp $ZOOKEEPER_FILE /usr/local/kafka/config/
  cp SERVER_FILE.$1 /usr/local/kafka/config/SERVER_CONFIG
}

echo "setup kafka"
installKafka
installConfig
setupEnvVars
