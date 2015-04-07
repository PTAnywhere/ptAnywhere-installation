# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "192.168.34.2"
  config.vm.hostname = "ptinstallation"
  config.vm.synced_folder "../packetTracer", "/home/vagrant/pt", :mount_options => ["dmode=777", "fmode=666"]

  config.vm.provider :virtualbox do |vb|
    vb.memory = 2048
  end

end
