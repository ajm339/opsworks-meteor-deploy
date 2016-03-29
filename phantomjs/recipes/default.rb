#
# Cookbook Name:: phantomjs
# Recipe:: default
#
# Copyright 2015, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#

execute "Install phantomjs" do
	user "root"
	command "npm install phantomjs-prebuilt"
end