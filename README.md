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


### Create a base PT installation

To install PT on a Linux machine, you could [do it manually](https://www.youtube.com/watch?v=7A2rIcwl_co) or use the Ansible script in this project.

However, the easiest procedure is to create a VM which contains a PT installation (from now on the __installation VM__) using the following command:

    MACHINES='./vagrant/only_packetTracer.rb' vagrant up


__Before__ executing this command make sure that:

 * _installation\_file_ inside the _group\_vars/pt\_backend_ file points to a _tar.gz_ file with the base PacketTracer installation. For example, the one you have downloaded from the official site.
 * _pt\_configuration\_file_ inside the _group\_vars/pt\_backend_ file is set to _False_. Alternatively you can add the path to a previous PacketTracer configuration file.
 * The folder _/tmp/backup_ exists. You could also change the folder to be synced in _vagrant/only\_packetTracer.rb_.


### Configure PT

Access the machine where PT is installed and run PT for the first time.
If you have created the _installation VM_ as suggested, simply start a VNC session on _vnc://192.168.35.2:5901_.

Once you have started PT, configure the following options:
 * Configure IPC
   * Go to Extensions > IPC > Options...
   * Listen Port Number: 39000.
   * Always Listen On Start: checked.
 * Save the options
   * Go to Options > Preferences > Write Options To PT Installed Folder
   * Press the "Write" button.


### Back up the configuration files

If you are creating the base installation using the _installation VM_ as suggested, run the following command.
It will create a folder with the desired files in the _/tmp/backup_ directory.

    MACHINES='./vagrant/only_packetTracer.rb' BACKUP=true vagrant provision


Otherwise, manually back up the following files:

 * PT installation directory: ```cd {INSTALLATION_PATH}; tar -zcvf installation.tar.gz ./*```
 * PT configuration file: ```cd; cp .packettracer packettracer.conf```
   * Note that this is a hidden file in the home directory of the user who run PT.

__Note__: You could also only copy PT's installation and run it for the first time in each newly provisioned VM or container.
However, this will require your intervention for each machine (you will need to close an emerging dialog which appears the first time you run PT).
To ensure that PT starts automatically without human intervention (i.e., that no dialogs are shown in PT), we need to be sure to also copy the last two listed files.


### Tell Ansible where these files are

For this, you need to customize _group\_vars/pt\_backend_ 

 * _installation\_file_ should point to _installation.tar.gz_.
 * _pt\_configuration\_file_ should point to _packettracer.conf_.


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

The base configuration file can be found in _vagrant/only_packetTracer.rb_.
This file defines a web server called _websvr_ where the [PTAnywhere](https://github.com/gomezgoiri/ptAnywhere) app should be deployed and a support machine called _node1_ which will have an [HTTP API to manage PT instances](https://github.com/gomezgoiri/pt-instances-management) using Docker.
To create more support machines edite the configuration file on _NOTE 1_.


To create these VMs:
 1. Install [Vagrant](https://www.vagrantup.com/) in the host.
 2. Go to this project's root directory and type ```vagrant up```. <br />
    This command creates the machines defined in the configuration file and an Ansible inventory file for them (see _.vagrant/provisioners/ansible/inventory_).
 3. Access _node1_ with ```vagrant ssh node1```.
 4. Create the base container for PacketTracer instances (only needed the first time): ```docker build --rm -t bla ./```

Once you have completed these steps, you will be able to:
 * Deploy [PTAnywhere](https://github.com/gomezgoiri/ptAnywhere) in _websvr_.
 * Access and create new instances using the web application on _node1_'s port 80.
