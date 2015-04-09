# Remote PacketTracer installation
PacketTracer installation listening on port 40000 (IPC) for a Linux distribution using Ansible.

## Requisites

 * The control machine needs to have [Ansible installed](http://www.ansible.com).
 * The control machine needs to have a PacketTracer directory with this program already installed and configured.
  * Customize the _original\_path_ variable in _roles/packetTracer/defaults/main.yml_
 * The control machine needs to access the machine (or machines) where PT will be installed through SSH (it needs a private key).
  * Specify where PT will be installed by editing the _machine_ file. 
  * Specify the remote user through the _-u_ parameter and in the _group\_vars/local_ file (_remote\_user_ variable)
  * Specify the private key location through the _--private-key_ parameter.

## Typical usage

Go to this project's root directory and simply type:

    ansible-playbook -vvvv -u [remote-user] -l 'local' -i machine --private-key [private-key-location] main.yml

If everything goes smoothly, you will be able to connect to the port 5901 with a VNC client and see the PacketTracer instance running.

## VM creation

The Ansible playbook can be used to install PT in any Linux machine with SSH access.

However, this project also provides a file to create a local virtual machine where we can install it.

To create this VM:
 1. Install [Vagrant](https://www.vagrantup.com/) in the host.

 2. Go to this project's root directory and type ```vagrant up```
 
 3. Run the Ansible playbook with the following parameters:
```
    ansible-playbook -vvvv -u vagrant -l 'local' -i machine --private-key .vagrant/machines/default/virtualbox/private_key main.yml
```
 4. Access to this machine (if you want) with ```vagrant ssh```
 5. See the PacketTracer instance running by connecting with a VNC client to: vnc://192.168.34.2:5901
