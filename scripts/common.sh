#!/bin/bash

#java
JAVA_VERSION=jdk-8u131-linux-x64
JAVA_ARCHIVE=$JAVA_VERSION.tar.gz
JAVA_HOME=jdk1.8.0_131
#hadoop
HADOOP_PREFIX=/usr/local/hadoop
HADOOP_CONF=$HADOOP_PREFIX/etc/hadoop
HADOOP_VERSION=hadoop-2.6.0
HADOOP_ARCHIVE=$HADOOP_VERSION.tar.gz
HADOOP_MIRROR_DOWNLOAD=../resources/hadoop-2.6.0.tar.gz
HADOOP_RES_DIR=/vagrant/resources/hadoop
#spark
SPARK_VERSION=spark-2.1.1
SPARK_HOME=$SPARK_VERSION-bin-hadoop2.7
SPARK_ARCHIVE=$SPARK_HOME.tgz
SPARK_MIRROR_DOWNLOAD=../resources/$SPARK_ARCHIVE
SPARK_RES_DIR=/vagrant/resources/spark
SPARK_CONF_DIR=/usr/local/spark/conf
#kafka
KAFKA_VERSION=kafka_2.12-0.10.2.1
KAFKA_ARCHIVE=$KAFKA_VERSION.tgz
KAFKA_MIRROR_DOWNLOAD=../resources/kafka/$KAFKA_ARCHIVE
#ssh
SSH_RES_DIR=/vagrant/resources/ssh
RES_SSH_COPYID_ORIGINAL=$SSH_RES_DIR/ssh-copy-id.original
RES_SSH_COPYID_MODIFIED=$SSH_RES_DIR/ssh-copy-id.modified
RES_SSH_CONFIG=$SSH_RES_DIR/config

function resourceExists {
	FILE=/vagrant/resources/$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

function fileExists {
	FILE=$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

#echo "common loaded"
