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
  cwd "/root"
  code <<-EOH
    curl -sL https://deb.nodesource.com/setup_0.10 | sudo -E bash -
    sudo apt-get install -y nodejs
  EOH
end

bash "install g++ dependency for fibers" do 
  user "root"
  cwd "/root"
  code <<-EOH
    sudo apt-get install -y g++
  EOH
end

bash "install build-essential" do 
  user "root"
  cwd "/root"
  code <<-EOH
    sudo apt-get install -y build-essential
  EOH
end