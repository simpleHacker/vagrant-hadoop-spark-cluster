# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.4.3"
VAGRANTFILE_API_VERSION = "2"

# the domain of all the nodes
DOMAIN = 'local'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	numNodes = 4
	r = numNodes..1
	(r.first).downto(r.last).each do |i|
		config.vm.define "node-#{i}" do |node|
			node.vm.box = "precise64"
			node.vm.box_url = "http://files.vagrantup.com/precise64.box"
			node.vm.provider "virtualbox" do |v|
        v.gui = false
			  v.name = "node#{i}"
			  v.customize ["modifyvm", :id, "--memory", "2048"]
        v.customize ['modifyvm', :id, '--cpus', "1"]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
			end
		  node.vm.network :private_network, ip: "10.0.100.1#{i}"
			node.vm.hostname = "node#{i}"

      # fix standin is not tty error
			node.vm.provision "fix-no-tty", type: "shell" do |s|
        s.privileged = false
        s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
      end

      node.vm.provision "shell", path: "scripts/setup-centos.sh"
			node.vm.provision "shell" do |s|
				s.path = "scripts/setup-centos-hosts.sh"
				s.args = "-t #{numNodes}"
			end
			if i == 2
				node.vm.provision "shell" do |s|
					s.path = "scripts/setup-centos-ssh.sh"
					s.args = "-s 3 -t #{numNodes}"
				end
			end
			if i == 1
				node.vm.provision "shell" do |s|
					s.path = "scripts/setup-centos-ssh.sh"
					s.args = "-s 2 -t #{numNodes}"
				end
			end
			node.vm.provision "shell", path: "scripts/setup-java.sh"
			node.vm.provision "shell", path: "scripts/setup-hadoop.sh"
			node.vm.provision "shell" do |s|
				s.path = "scripts/setup-hadoop-slaves.sh"
				s.args = "-s 3 -t #{numNodes}"
			end
			node.vm.provision "shell", path: "scripts/setup-spark.sh"
			node.vm.provision "shell" do |s|
				s.path = "scripts/setup-spark-slaves.sh"
				s.args = "-s 3 -t #{numNodes}"
			end
		end
	end
end
