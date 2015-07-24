# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"


number_of_machines = 1
box = "chef/centos-7.0"
memory = 2048


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.provision "ansible" do |ansible|
		ansible.groups = {
			"web" => ["websvr"],
			"scheduling" => ["websvr"],
			"pt_backend" => Array.new(number_of_machines){ |i| "node#{i+1}" },
			"local:children" => ["web", "scheduling", "pt_backend"]
		}
		ansible.playbook = "main.yml"
		# Useful during testing 
		ansible.host_key_checking = false
		# ansible.verbose = "vvvv"
		# ansible.inventory_path = "path"  # In this case we directly generate it
		# ansible.limit = "local"
		# ansible.raw_arguments = "--ask-vault-pass"
	end


	# Disabling the default /vagrant share.
	#   http://docs.vagrantup.com/v2/synced-folders/
	#   (Reason to disable it: In MacOS GuestAdditions trend to fail screwing the "up" or "reload".
	config.vm.synced_folder ".", "/vagrant", disabled: true

	(1..number_of_machines).each do |i|
		config.vm.define "node#{i}" do |node|
			node.vm.box = box
			node.vm.network "private_network", ip: "192.168.34.#{i+1}"
			node.vm.hostname = "pt#{i}"
			node.vm.provider :virtualbox do |vb|
				vb.memory = memory
			end
		end
	end

	config.vm.define "websvr" do |node|
		node.vm.box = box
		node.vm.network "private_network", ip: "192.168.34.201"
		node.vm.network "forwarded_port", guest: 8080, host: 8080
		node.vm.hostname = "websvr"
		node.vm.provider :virtualbox do |vb|
			vb.memory = 512
		end
	end
end

