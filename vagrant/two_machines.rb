=begin

This file creates an installation with two machines:
  + websvr: where the web server and the scheduling module are installed.
  + node1 : which creates PacketTracer instances using Docker.

Note that more backend machines can be easily created by editing the
parameter marked with "NOTE 1".

=end



 # number_of_machines should be <= 254
def create_backend_machines_from_template(number_of_machines, first_ip, template)
  ret = []
  (0..number_of_machines-1).each do |i|
    ret.push({
      "hostname" => template["hostname"] + "#{i+1}",
      "ip" => template["ip"] + "#{i+first_ip}",
      "box" => template["box"],
      "memory" => template["memory"],
      "cpus" => template["cpus"],
      "ports" => template["ports"],
      "ansible_groups" => template["ansible_groups"]
    })
  end
  return ret
end



box = "chef/centos-7.0"

websvrs = [{
    "hostname"=> "websvr",
    "ip"=> "192.168.34.201",
    "box"=> box,
    "memory"=> 512,
    "cpus"=> 1,
    "ports"=> [ [8080, 8080], ],
    "ansible_groups" => ["web", "scheduling"]
  },
]


MACHINES =  websvrs + create_backend_machines_from_template(
                          1,  # NOTE 1: Edit this parameter to create more backend machines.
                          2,
                          {
                            "hostname"=> "node",
                            "ip"=> "192.168.34.",
                            "box"=> box,
                            "memory"=> 2048,
                            "cpus"=> 1,
                            "ports"=> [],
                            "ansible_groups" => ["pt_backend"]
                          }
                      )
