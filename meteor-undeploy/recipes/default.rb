#
# Cookbook Name:: meteor-undeploy
# Recipe:: default
#
# Copyright 2015, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#

execute "Stop Meteor as Node Application" do
	user "root"
	command "forever stopall"
end