# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "Ubuntu14"
    #config.vm.box_url = "https://vagrantcloud.com/ubuntu/trusty64"
    
    config.vm.network :private_network, ip: "192.168.33.10"
    config.vm.network "forwarded_port", guest: 80, host: 8765


    config.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--memory", 1024]
        v.customize ["modifyvm", :id, "--name", "D8Lab"]
    end

    config.vm.synced_folder "www", "/var/www", create: true,type: "nfs"
    #,:mount_options => ["dmode=777","fmode=666"]
    config.vm.synced_folder "sqldump", "/var/sqldump", create: true
    config.vm.synced_folder "scripts", "/var/scripts", create: true
    config.vm.synced_folder "custom_config_files", "/var/custom_config_files", create: true

    config.vm.provision :shell, :path => "bootstrap.sh"
    
    # config.vm.provision :shell, run: "always", :path => "load.sh"
end
