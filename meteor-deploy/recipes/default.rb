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
	cwd "#{node["deploy"]["macrofuel_store"]["deploy_to"]}/current/programs/server"
	code <<-EOH
		npm install
	EOH
end

if( defined?( node["deploy"]["macrofuel_store"]["DISABLE_WEBSOCKETS"] ) )

	execute "Start Meteor as Node Application with Websockets enabled (no DISABLE_WEBSOCKETS option available)" do
		cwd "#{node["deploy"]["macrofuel_store"]["deploy_to"]}/current"
		command "PORT=#{node["deploy"]["macrofuel_store"]["PORT"]} MONGO_URL=#{node["deploy"]["macrofuel_store"]["MONGO_URL"]} ROOT_URL=#{node["deploy"]["macrofuel_store"]["ROOT_URL"]} MAIL_URL=#{node["deploy"]["macrofuel_store"]["MAIL_URL"]} forever start main.js"
	end

else

	execute "Start Meteor as Node Application with Websockets option defined in Stack Settings" do
		cwd "#{node["deploy"]["macrofuel_store"]["deploy_to"]}/current"
		command "PORT=#{node["deploy"]["macrofuel_store"]["PORT"]} MONGO_URL=#{node["deploy"]["macrofuel_store"]["MONGO_URL"]} ROOT_URL=#{node["deploy"]["macrofuel_store"]["ROOT_URL"]} MAIL_URL=#{node["deploy"]["macrofuel_store"]["MAIL_URL"]} DISABLE_WEBSOCKETS=#{node["deploy"]["macrofuel_store"]["DISABLE_WEBSOCKETS"]} forever start main.js"
		end
end