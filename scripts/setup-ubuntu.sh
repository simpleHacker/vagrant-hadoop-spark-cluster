#!/bin/bash
source "/vagrant/scripts/common.sh"

function disableFirewall {
	echo "disabling firewall"
	ufw disable
}

function setupSudoer {
    echo "add vagrant into sudoers"
    echo "vagrant ALL=NOPASSWD:ALL" > /etc/sudoers.d/vagrant
    chmod 0440 /etc/sudoers.d/vagrant
}

function setupLogs {
    echo "create logs"
    mkdir /logs
    chmod 775 /logs
}

echo "setup ubuntu"
disableFirewall

echo "setup sudoer"
setupSudoer

echo "setup logs"
setupLogs
