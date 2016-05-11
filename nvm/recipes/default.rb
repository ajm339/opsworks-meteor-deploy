#
# Cookbook Name:: nvm
# Recipe:: default
#
# Copyright 2016, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#
# based on https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server

bash "choose nvm node v0.10.45" do 
  user "root"
  code <<-EOH
    nvm install 0.10.45
    nvm use 0.10.45
  EOH
end