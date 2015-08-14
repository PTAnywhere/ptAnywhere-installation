# PTAnywhere installation

PTAnywhere installation script for a Linux distribution using Ansible (and optionally Vagrant).

## Usage

Please go to [project wiki](https://github.com/PTAnywhere/ptAnywhere-installation/wiki/) to find extensive documentation on how to use these installation scripts:

 * [Requisites](https://github.com/PTAnywhere/ptAnywhere-installation/wiki/Requirements)
 * [How does a typical PTAnywhere installation look like?](https://github.com/PTAnywhere/ptAnywhere-installation/wiki/Typical-PTAnywhere-installation)
 * [Preparing the PT installation](https://github.com/PTAnywhere/ptAnywhere-installation/wiki/Preparing-the-PT-installation)
 * [Install PTAnywhere in any machine](https://github.com/PTAnywhere/ptAnywhere-installation/wiki/Install-PTAnywhere-using-Ansible) (using Ansible)
 * [Install PTAnywhere in predefined local Virtual Machines](https://github.com/PTAnywhere/ptAnywhere-installation/wiki/Install-PTAnywhere-using-Vagrant) (using Vagrant)


## Troubleshooting

 * Ansible throws an error which says: ```Missing become password```.
  * What happens? The remote user you are running needs to introduce a password to become sudo.
  * Quick solution: Add the ```--ask-become-pass``` parameter.
 * The PT instance gets stuck in a machine running behind a HTTP proxy and logs don't show any meaningul information.
  * Strange as it may sound, you might want to [unset the proxy for PacketTracer](https://github.com/PTAnywhere/ptAnywhere-installation/commit/b7518b994264c0516e540e21261e96cf6bc77318).


## Acknowledgements

This installation scripts were made as part of the [FORGE project](http://ict-forge.eu/).
