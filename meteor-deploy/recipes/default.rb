#
# Cookbook Name:: meteor-deploy
# Recipe:: default
#
# Copyright 2015, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#

bash "meteor install" do 
	user "root"
	cwd "#{node["deploy"]["YOUR_APP_NAME"]["deploy_to"]}/current/programs/server"
	code <<-EOH
		npm install
	EOH
end

execute "Start Meteor as Node Application" do
	cwd "#{node["deploy"]["YOUR_APP_NAME"]["deploy_to"]}/current"
	command "PORT=#{node["deploy"]["YOUR_APP_NAME"]["PORT"]} MONGO_URL=#{node["deploy"]["YOUR_APP_NAME"]["MONGO_URL"]} ROOT_URL=#{node["deploy"]["YOUR_APP_NAME"]["ROOT_URL"]} MAIL_URL=#{node["deploy"]["YOUR_APP_NAME"]["MAIL_URL"]} forever start main.js"
end