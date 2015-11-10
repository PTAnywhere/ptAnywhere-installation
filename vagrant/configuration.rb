=begin

This file creates a PT installation in a Ubuntu machine with VNC access.

This VM can be used to configure the PacketTracer installation that
will be used as a base for the Docker-based installation afterwards.

=end

backup = ENV['BACKUP']
backup ||= false

ANSIBLE_PLAYBOOK = "ptonly.yml" # unless backup
ANSIBLE_PLAYBOOK = "ptonly_backup.yml" if backup


MACHINES = [
  {
    "hostname"=> "packetTracer",
    "ip"=> "192.168.34.203",
    "box"=> "chef/centos-7.0",
    "memory"=> 512,
    "cpus"=> 1,
    "ports"=> [],
    "ansible_groups" => ["pt_configuration"]
  },
]
