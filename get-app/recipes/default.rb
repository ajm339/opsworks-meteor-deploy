#
# Cookbook Name:: get-app
# Recipe:: default
#
# Copyright 2016, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#

app = search("aws_opsworks_app").first

bash "remove previous version" do 
  user "root"
  cwd "/root"
  ignore_failure true
  code <<-EOH
    forever stopall
    rm -rf bundle
    rm #{app['name']}.tar.gz
  EOH
end

bash "get app and unbundle it" do 
  user "root"
  cwd "/root"
  code <<-EOH
    wget #{app['app_source']['url']}
    tar -zxvf #{app['name']}.tar.gz
  EOH
end