# Remote PacketTracer installation
PacketTracer installation listening on port 39000 (IPC) for a Linux distribution using Ansible.

## Requisites

 * The control machine needs to have [Ansible installed](http://www.ansible.com).
 * The control machine needs to have a directory containing a _Packet Tracer_ installation. Please, check the [next section](#preparing-pt-installation) to learn how to install and configure it.
 * The control machine needs to access the machine (or machines) where PT will be installed through SSH (it needs a private key).
  * Specify where PT will be installed by editing the _machine_ file. 
  * Specify the remote user through the _-u_ parameter and in the _group\_vars/local_ file (_remote\_user_ variable)
  * Specify the private key location through the _--private-key_ parameter.

##  <a name="preparing-pt-installation">Preparing the PT installation</a>

I cannot provide an already configured _Packet Tracer_ installation for intellectual property reasons.
However, you can [get PT here](https://www.netacad.com/about-networking-academy/packet-tracer) and follow the following instructions to configure it.

To install PT on a Linux machine, you could [do it manually](https://www.youtube.com/watch?v=7A2rIcwl_co) or use the Ansible script in this project.
However, the easiest procedure is to create a VM which contains a PT installation using the following command:

    MACHINES='./vagrant/only_packetTracer.rb' vagrant up

After installing it,

  * Run it for the first time and configure the following options ():
   * Configure IPC
     * Go to Extensions > IPC > Options...
     * Listen Port Number: 39000.
     * Always Listen On Start: checked.
   * Save the options
     * Go to Options > Preferences > Write Options To PT Installed Folder
     * Press the "Write" button.
  * Back up the following files:
   * PT installation directory: ```cd {INSTALLATION_PATH}; tar -zcvf installation.tar.gz ./*```
   * PT configuration file: ```cd; cp .packettracer packettracer.conf```
     * Note that this is a hidden file in the home directory of the user who run PT.
   * [TODO] provide a backup script
  * Customize _roles/packetTracer/defaults/main.yml_ 
   * _original\_path_ should point to PT's installation path.
   * [TODO] rest of the variables.

__Note__: You could also only copy PT's installation and run it for the first time in each newly provisioned VM or container.
However, this will require your intervention for each machine (you will need to close an emerging dialog which appears the first time you run PT).
To ensure that PT starts automatically without human intervention (i.e., that no dialogs are shown in PT), we need to be sure to also copy the last two listed files.


## Typical usage

Edit the inventory file called __machine__ to specify your machine(s) details.

Go to this project's root directory and simply type:

    ansible-playbook -vvvv -u [remote-user] -l 'local' -i machine --private-key [private-key-location] ptinstances.yml

If everything goes smoothly, you will be able to connect to the port 5901 with a VNC client and see the PacketTracer instance running.

If you also want to install the web application server and its dependencies try:

    ansible-playbook -vvvv -u [remote-user] -l 'local' -i machine --private-key [private-key-location] main.yml

## VM creation

The Ansible playbook can be used to install PT in any Linux machine with SSH access.

However, this project also provides a file to create one or multiple local virtual machine/s where we can install it (together with a web server and a Redis server).

To create these VMs:
 1. Install [Vagrant](https://www.vagrantup.com/) in the host.
 2. Go to this project's root directory and type ```vagrant up```. <br />
    This command creates the machines defined in the configuration file and an Ansible inventory file for them (see _.vagrant/provisioners/ansible/inventory_).
 3. Access this machine (if you want) with ```vagrant ssh [node-name]```. <br />
    For a manual log in using _ssh_, simply type ```ssh -i .vagrant/machines/default/virtualbox/private_key [machine_ip]```.
 4. See the PacketTracer instance running by connecting with a VNC client to: __vnc://[machine_ip]:5901__
