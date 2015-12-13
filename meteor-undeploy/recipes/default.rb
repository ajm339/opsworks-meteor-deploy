#
# Cookbook Name:: meteor-undeploy
# Recipe:: default
#
# Copyright 2015, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#

execute "Stop Meteor as Node Application" do
	cwd "#{node["deploy"]["YOUR_APP_NAME"]["deploy_to"]}/current"
	command "forever stop main.js"
end