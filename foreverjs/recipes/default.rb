#
# Cookbook Name:: foreverjs
# Recipe:: default
#
# Copyright 2015, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#
execute "install foreverjs" do
	user "root"
  command "npm install forever -g"
end