# -*- mode: ruby -*-
# vi: set ft=ruby :


VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  os = "ubuntu/trusty64"
  box_url = "https://app.vagrantup.com/ubuntu/boxes/trusty64"
  net_ip = "172.17.17"
  # For masterless, mount your salt file root
  config.vm.synced_folder "saltstack/roots/", "/srv/salt/"


    config.vm.define :haproxy, primary: true do |haproxy_config|
      haproxy_config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 1
        vb.name = "haproxy"
      end


      haproxy_config.vm.box = "#{os}"
      haproxy_config.vm.box_url = "#{box_url}"
      haproxy_config.vm.hostname = "haproxy"
      haproxy_config.vm.network :private_network, ip: "#{net_ip}.10"
      haproxy_config.vm.network :forwarded_port, guest: 8080, host: 8080
      haproxy_config.vm.network :forwarded_port, guest: 80, host: 8081
      haproxy_config.vm.provision :shell, :path => "haproxy-setup.sh"

      haproxy_config.vm.provision :salt do |salt|
	salt.masterless = true
        salt.minion_config = "saltstack/etc/minion-roots"
        salt.grains_config = "saltstack/etc/haproxy-grains"
	salt.run_highstate = true
      end
    end




  [
      ["web1",    "#{net_ip}.11",    "1024",    os ],
      ["web2",    "#{net_ip}.12",    "1024",    os ],
      ["web3",    "#{net_ip}.13",    "1024",    os ]
  ].each do |vmname,ip,mem,os|
    config.vm.define "#{vmname}" do |minion_config|
      minion_config.vm.provider "virtualbox" do |vb|
        vb.memory = "#{mem}"
        vb.cpus = 1
        vb.name = "#{vmname}"
      end
      minion_config.vm.box = "#{os}"
      minion_config.vm.box_url = "#{box_url}"
      minion_config.vm.hostname = "#{vmname}"
      minion_config.vm.network "private_network", ip: "#{ip}"

      minion_config.vm.provision :salt do |salt|
	salt.masterless = true
	salt.minion_config = "saltstack/etc/minion-roots"
	salt.grains_config = "saltstack/etc/webserver-grains"
	salt.run_highstate = true
      end
      minion_config.vm.provision :shell, :path => "web-setup.sh"
    end
  end
end
