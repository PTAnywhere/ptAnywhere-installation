=begin

This file creates a PT installation in a Ubuntu machine with VNC access.

This VM can be used to configure the PacketTracer installation that
will be used as a base for the Docker-based installation afterwards.

=end


ANSIBLE_PLAYBOOK = "ptonly.yml"
MACHINES = [
  {
    "hostname"=> "packetTracer",
    "ip"=> "192.168.35.2",
    "box"=> "ubuntu/trusty64",
    "memory"=> 512,
    "cpus"=> 1,
    "ports"=> [],
    "ansible_groups" => ["pt_backend"]
  },
]