#
# Cookbook Name:: nvm
# Recipe:: default
#
# Copyright 2016, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#
# based on https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server

bash "download nvm" do 
  user "root"
  code <<-EOH
    sudo apt-get update
    sudo apt-get install build-essential libssl-dev
    curl https://raw.githubusercontent.com/creationix/nvm/v0.16.1/install.sh | sh
    source ~/.profile
    nvm install 0.10.45
    nvm use 0.10.45
  EOH
end