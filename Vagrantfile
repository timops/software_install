require 'berkshelf/vagrant'

Vagrant::Config.run do |config|
  # The path to the Berksfile to use with Vagrant Berkshelf
  #config.berkshelf.berksfile_path = "./Berksfile"

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.only = []

  config.vm.define :guest do |master_config|
    master_config.vm.host_name = "swtest"
    master_config.vm.box = "Berkshelf-CentOS-6.3-x86_64-minimal"
    master_config.vm.box_url = "https://dl.dropbox.com/u/31081437/Berkshelf-CentOS-6.3-x86_64-minimal.box"

    master_config.vm.network :hostonly, "172.16.65.200"
    master_config.ssh.max_tries = 40
    master_config.ssh.timeout   = 120
    master_config.ssh.forward_agent = true

    # uncomment to use vagrant shell provisioner to get lateste Chef-client.
=begin
    master_config.vm.provision :shell, :inline => <<-INSTALL_OMNIBUS
    if [ ! -d '/opt/chef' ] || 
       [ ! $(chef-solo --v | awk "{print \\$2}") = "#{OMNIBUS_CHEF_VERSION}" ]
    then
       wget -qO- https://www.opscode.com/chef/install.sh | sudo bash -s -- -v "#{OMNIBUS_CHEF_VERSION}"
    else
       echo "Chef #{OMNIBUS_CHEF_VERSION} already installed...skipping installation."
    fi 
    INSTALL_OMNIBUS
=end

    master_config.vm.provision :chef_client do |chef|
      chef.chef_server_url = "https://api.opscode.com/organizations/persuse"

      chef.validation_client_name = "persuse-validator"
      chef.validation_key_path = "#{ENV['HOME']}/.chef/persuse-validator.pem"
      chef.client_key_path = "/etc/chef/client.pem"

      chef.run_list = [
        "recipe[software_install]"
      ]
    end
  end
end
