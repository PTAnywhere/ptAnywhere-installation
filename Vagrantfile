# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"


number_of_machines = 3
box = "ubuntu/trusty64"
memory = 512


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.provision "ansible" do |ansible|
		ansible.groups = {
			"web" => ["websvr"],
			"pt_backend" => Array.new(number_of_machines){ |i| "node#{i+1}" },
			"local:children" => ["web", "pt_backend"]
		}
		ansible.playbook = "main.yml"
		# Useful during testing 
		ansible.host_key_checking = false
		# ansible.verbose = "vvvv"
		# ansible.inventory_path = "path"  # In this case we directly generate it
		# ansible.limit = "local"
	end


	(1..number_of_machines).each do |i|
		config.vm.define "node#{i}" do |node|
			node.vm.box = box
			node.vm.network "private_network", ip: "192.168.34.#{i}"
			node.vm.hostname = "pt#{i}"
			node.vm.provider :virtualbox do |vb|
				vb.memory = memory
			end
		end
	end

	config.vm.define "websvr" do |node|
		node.vm.box = box
		node.vm.network "private_network", ip: "192.168.34.201"
		node.vm.hostname = "websvr"
		node.vm.provider :virtualbox do |vb|
			vb.memory = memory
		end
	end
end

