#
# Cookbook Name:: node-v0.10.45
# Recipe:: default
#
# Copyright 2016, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#
# Following https://github.com/nodesource/distributions#debinstall

bash "install node v0.10.45" do 
  user "root"
  code <<-EOH
    curl -sL https://deb.nodesource.com/setup_0.10 | sudo -E bash -
    sudo apt-get install -y nodejs
  EOH
end

execute "create symlink from nodejs to node" do
  user "root"
  command "ln -s /usr/bin/nodejs /usr/local/bin/node"
  ignore_failure true
end