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
   # echo "Defaults exempt_group=sudo" >> /etc/sudoers
   # echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
   # echo "vagrant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
   # echo "Defaults:vagrant !requiretty" >> /etc/sudoers
}

echo "setup ubuntu"
disableFirewall

echo "setup sudoer"
setupSudoer
