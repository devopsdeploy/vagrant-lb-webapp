# Run multiple nginx webserver behind a HAProxy LB and bootstraping with saltstack
  - VirtualBox (Ubuntu)
  - Masterless Saltstack
  
## Prerequisites

- Install Vagrant

    I prefer using brew to install packages on a Mac OS X. See my blog post on how to setup and use brew.
    
    http://www.rominet.com/blog/homebrew-the-best-package-manager-for-mac-os
    
    `$>brew install vagrant-completion`
   
- Install VirtualBox

   `$>brew cask install virtualbox`
   
Alternatively you can also install Vagrant-Manager

[Vagrant-Manager](http://vagrantmanager.com) helps you manage all your virtual machines in one place directly from the menubar.

`$ brew cask install vagrant-manager`

## Nodes 
- haproxy (172.17.17.9)
- web1    (172.17.17.10)
- web2    (172.17.17.11)
- web3    (172.17.17.12)

## Installation

### Saltastack Setup
All the salt configuration will be stored under
./saltstack/salt
Salt will install common packages as follow (this is under saltstack/salt/common):
```common_packages:
  pkg.installed:
    - pkgs:
      - htop
      - strace
      - vim
      - wget
      - lynx
```
      
## Getting Started
- From your terminal, run:
  ```vagrant up```
   (This will launch all 4 machines)
- On your browser 

In this example the proxy timeouts for server and client are set to 5s so that every 5s you get a new server for demonstration purposes.

Connect to the LoadBalancer at: [http://172.17.17.10](http://172.17.17.10)
 
Connect to the LoadBalancer Statistics Admin page at:  [http://172.17.17.10:8080/haproxy?stats](http://172.17.17.10:8080/haproxy?stats)
 

To access the Webservers individually go to:

Web1 - [http://172.17.17.11](http://172.17.17.11)

Web2 - [http://172.17.17.12](http://172.17.17.12)

Web3 - [http://172.17.17.13](http://172.17.17.13)

### Single html root served by vagrant
If you want to deploy your html file in one location and be served to all 3 nodes make the following changes:

1) Edit web-setup.sh and uncomment the following line
`#sed -i "/^\troot */c\\\troot /vagrant/www/html;" /etc/nginx/sites-enabled/default`

### Applying salt changes
If you decide to make some changes to the system using salt, you can modify the files under saltstack/salt

From each node you can: (The command we will use is salt-call because this is a Masterless saltstack)

Apply changes - `$>salt-call state.apply`

List grains - `$>salt-call grains.ls`

List grain items - `$>salt-call grains.`items`

Grains are basically the metadata about your system.


NOTE: I think maybe docker provider may be a good choice instead of using VirtualBox. Or even better not use Vagrant at all but setup your dev environment completely on docker. Just a thought.