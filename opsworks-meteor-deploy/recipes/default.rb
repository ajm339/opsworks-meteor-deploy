#
# Cookbook Name:: opsworks-meteor-deploy
# Recipe:: default
#
# Copyright 2015, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#

bash "meteor install" do 
	user "root"
	cwd "#{node["deploy"]["macrofuel_meteor"]["deploy_to"]}/current/programs/server"
	code <<-EOH
		npm install
	EOH
end

service "meteor start" do
	init_command "cd #{node["deploy"]["macrofuel_meteor"]["deploy_to"]}/current"
	start_command "PORT=#{node["deploy"]["macrofuel_meteor"]["PORT"]} MONGO_URL=#{node["deploy"]["macrofuel_meteor"]["MONGO_URL"]} ROOT_URL=#{node["deploy"]["macrofuel_meteor"]["ROOT_URL"]} MAIL_URL=#{node["deploy"]["macrofuel_meteor"]["MAIL_URL"]} forever start main.js"
	restart_command "PORT=#{node["deploy"]["macrofuel_meteor"]["PORT"]} MONGO_URL=#{node["deploy"]["macrofuel_meteor"]["MONGO_URL"]} ROOT_URL=#{node["deploy"]["macrofuel_meteor"]["ROOT_URL"]} MAIL_URL=#{node["deploy"]["macrofuel_meteor"]["MAIL_URL"]} forever restart main.js"
	stop_command "forever stop main.js"
	action [:enable, :start, :restart, :stop]
end

# execute "Start Meteor as Node Application" do
# 	cwd "#{node["deploy"]["macrofuel_meteor"]["deploy_to"]}/current"
# 	command "PORT=#{node["deploy"]["macrofuel_meteor"]["PORT"]} MONGO_URL=#{node["deploy"]["macrofuel_meteor"]["MONGO_URL"]} ROOT_URL=#{node["deploy"]["macrofuel_meteor"]["ROOT_URL"]} MAIL_URL=#{node["deploy"]["macrofuel_meteor"]["MAIL_URL"]} node main.js"
# end

# bash "meteor start" do 
# 	user "root"
# 	cwd "#{node["deploy"]["macrofuel_meteor"]["deploy_to"]}/current"
# 	timeout 10
# 	code <<-EOH
# 		PORT=#{node["deploy"]["macrofuel_meteor"]["PORT"]} MONGO_URL=#{node["deploy"]["macrofuel_meteor"]["MONGO_URL"]} ROOT_URL=#{node["deploy"]["macrofuel_meteor"]["ROOT_URL"]} MAIL_URL=#{node["deploy"]["macrofuel_meteor"]["MAIL_URL"]} node main.js
# 	EOH
# end