=begin

This file creates an installation with a unique machine:
  + ptAnywere: where the web server, the scheduling module and the module
  which creates Packet Tracer instances (using Docker) are installed.

=end

MACHINES = [{
    "hostname"=> "ptanywhere",
    "ip"=> "192.168.34.202",
    "box"=> "chef/centos-7.0",
    "memory"=> 2048,
    "cpus"=> 1,
    "ports"=> [ [8080, 8080], ],
    "ansible_groups" => ["web", "scheduling", "pt_backend"]
  }]
