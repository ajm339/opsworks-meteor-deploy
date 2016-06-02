#
# Cookbook Name:: meteor-deploy
# Recipe:: default
#
# Copyright 2016, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#

bash "install fibers" do 
  user "root"
  cwd "/root/bundle/programs/server"
  code <<-EOH
    sudo npm install fibers
  EOH
end

bash "meteor install" do 
	user "root"
	cwd "/root/bundle/programs/server"
	code <<-EOH
		sudo npm install
	EOH
end

execute "Start Meteor as Node Application with Websockets option defined in Stack Settings" do
	user "root"
	cwd "/root/bundle"
	command startup_command
end

if( defined?( node["deploy"]["YOUR_APP_NAME"]["DISABLE_WEBSOCKETS"] ).nil? )

	execute "Start Meteor as Node Application with Websockets enabled (no DISABLE_WEBSOCKETS option available)" do
		user "root"
		cwd "/root/bundle"
		command "PORT=#{node["deploy"]["YOUR_APP_NAME"]["PORT"]} MONGO_URL=#{node["deploy"]["YOUR_APP_NAME"]["MONGO_URL"]} ROOT_URL=#{node["deploy"]["YOUR_APP_NAME"]["ROOT_URL"]} MAIL_URL=#{node["deploy"]["YOUR_APP_NAME"]["MAIL_URL"]} forever start main.js"
	end

else

	execute "Start Meteor as Node Application with Websockets option defined in Stack Settings" do
		user "root"
		cwd "/root/bundle"
		command "PORT=#{node["deploy"]["YOUR_APP_NAME"]["PORT"]} MONGO_URL=#{node["deploy"]["YOUR_APP_NAME"]["MONGO_URL"]} ROOT_URL=#{node["deploy"]["YOUR_APP_NAME"]["ROOT_URL"]} MAIL_URL=#{node["deploy"]["YOUR_APP_NAME"]["MAIL_URL"]} DISABLE_WEBSOCKETS=#{node["deploy"]["YOUR_APP_NAME"]["DISABLE_WEBSOCKETS"]} forever start main.js"
		end
		
end