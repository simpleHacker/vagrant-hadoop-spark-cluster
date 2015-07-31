#!/bin/bash
source "/vagrant/scripts/common.sh"

function disableFirewall {
	echo "disabling firewall"
	ufw disable
}

echo "setup ubuntu"

disableFirewall
