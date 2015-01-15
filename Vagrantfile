# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64" # Use "gce" if deploying to Google Cloud.
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :private_network, ip: "192.168.33.33"
  config.vm.synced_folder "./", "/opt/repository"

  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # Instructions for providing to Google Cloud Services:
  #
  # 1. Configure the Google Cloud provider below with your credentials.
  # 2. $ vagrant plugin install vagrant-google
  # 3. $ vagrant box add gce https://github.com/mitchellh/vagrant-google/raw/master/google.box
  # 4. $ vagrant up --provider=google
  config.vm.provider :google do |google, override|
    google.google_project_id = "YOUR_GOOGLE_CLOUD_PROJECT_ID"
    google.google_client_email = "YOUR_SERVICE_ACCOUNT_EMAIL_ADDRESS"
    google.google_key_location = "/PATH/TO/YOUR/PRIVATE_KEY.p12"

    google.name = "mastery"
    google.image = "ubuntu-1404-trusty-v20141212"
    google.machine_type = "f1-micro"
    google.zone = "europe-west1-c"
    google.network = "default"
    google.tags = ["http-server"]

    override.ssh.username = "USERNAME"
    override.ssh.private_key_path = "~/.ssh/id_rsa" # "~/.ssh/google_compute_engine"
  end

  config.vm.provision :shell do |shell|
    shell.inline = "apt-get install puppet -y"
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "main.pp"
    puppet.module_path    = "puppet/modules"
  end
end

