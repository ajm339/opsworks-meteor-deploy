#
# Cookbook Name:: opsworks-meteor-deploy
# Recipe:: default
#
# Copyright 2015, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#

# execute "Change to Meteor Application Directory" do
#   command "cd "
# end

# execute "Configure Meteor Dependencies with npm install" do
#   command "(cd programs/server && npm install)"
# end

# execute "Start Meteor as Node Application" do
#   command "node main.js"
# end

bash "meteor install" do 
	user "root"
	cwd "#{node["deploy"]["macrofuel_meteor"]["deploy_to"]}/current/programs/server"
	code <<-EOH
		npm install
	EOH
end

bash "meteor start" do 
	user "root"
	cwd "#{node["deploy"]["macrofuel_meteor"]["deploy_to"]}/current"
	code <<-EOH
		node main.js
	EOH
end