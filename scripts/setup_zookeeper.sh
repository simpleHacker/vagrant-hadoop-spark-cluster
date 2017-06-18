#!/bin/bash
source "/vagrant/scripts/common.sh"

function installRemoteZookeeper {
  echo "install zookeeper from remote file"
  curl -o /vagrant/resources/$ZOOKEEPER_ARCHIVE -O -L $ZOOKEEPER_MIRROR_DOWNLOAD
  tar -xzf /vagant/resources/$ZOOKEEPER_ARCHIVE -C /usr/local
}

function installLocalZookeeper {
  echo "install zookeeper from local file"
  FILE=/vagrant/resources/$ZOOKEEPER_ARCHIVE
  tar -xzf $FILE -C /usr/local
}

function installZookeeper {
  if resourceExists $ZOOKEEPER; then
    installLocalZookeeper
  else
    installRemoteZookeeper
  fi
  ln -s /usr/local/$ZOOKEEPER_VERSION /usr/local/zookeeper    
  mkdir /logs/zookeeper
}

function setupEnvVars {
  echo "creating zookeeper environment variables"
  export PATH=/usr/local/zookeeper/bin:${PATH}
}

function setupConfig {
  echo "install zookeeper config"
  ZOOKEEPER_CONFIG=zookeeper.properties
  ZOOKEEPER_FILE=/vagrant/resources/kafka/zookeeper.properties
  cp -f $ZOOKEEPER_FILE /usr/local/zookeeper/config
  touch /logs/zookeeper/myid
  echo $1 >> /logs/zookeeper/myid
}

echo "setup zookeeper for $1"
installZookeeper
setupConfig $1
setupEnvVars
