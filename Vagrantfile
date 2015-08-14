# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"


machines_file = ENV['MACHINES']
machines_file ||= './vagrant/one_machine'
require machines_file


# Assings a default playbook if another one has not been defined in the config file.
ANSIBLE_PLAYBOOK ||= "main.yml"



# Assign machines to their Ansible groups
def generate_ansible_groups(machines)
	require 'set'
	ansible_groups = {}
	all = Set.new
	ansible_groups["pt_installation:children"] = ["pt_backend", "pt_configuration"]
	machines.each do |m|
	  m["ansible_groups"].each do |group|
	    if not ansible_groups.has_key?(group)
	      ansible_groups[group] = []
	    end
	    if not ansible_groups.has_key?("local:vars")
	      ansible_groups["local:vars"] = []
	    end
	    ansible_groups[group].push(m["hostname"])
			# if does not contain a set...
			if ansible_groups["pt_installation:children"].include?(group)
				all = all.add("pt_installation")  # Adding special supergroup instead of the group
			else
	    	all = all.add(group)
			end
	  end
	end
	ansible_groups["local:children"] = all.to_a
	return ansible_groups
end



Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.provision "ansible" do |ansible|
		ansible.groups = generate_ansible_groups(MACHINES)
		ansible.playbook = ANSIBLE_PLAYBOOK
		ansible.host_key_checking = false  # Useful during testing
		# ansible.verbose = "vvvv"
		# ansible.inventory_path = "path"  # In this case we directly generate it
		# ansible.limit = "local"
		# ansible.raw_arguments = "--ask-vault-pass"
		# ansible.extra_vars = { var_name: value }
	end


	# Disabling the default /vagrant share.
	#   http://docs.vagrantup.com/v2/synced-folders/
	#   (Reason to disable it: In MacOS GuestAdditions trend to fail screwing the "up" or "reload".
	config.vm.synced_folder ".", "/vagrant", disabled: true


	MACHINES.each do |m|
		config.vm.define m["hostname"] do |node|
			node.vm.box = m["box"]
			node.vm.hostname = m["hostname"]
			node.vm.network :private_network, ip: m["ip"]

			m["ports"].each do |port|
				node.vm.network :forwarded_port, guest: port[0], host: port[1]
			end

			node.vm.provider :virtualbox do |vb|
				vb.cpus = m["cpus"]
				vb.memory = m["memory"]
			end
		end
	end
end
