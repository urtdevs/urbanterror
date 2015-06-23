#
# Cookbook Name:: urbanterror
# Recipe:: default
#
# Copyright (c) 2015 Jon Chen, All Rights Reserved.
require 'etc'

directory node["urbanterror"]["dir"] do
  owner node["urbanterror"]["user"]
  group node["urbanterror"]["group"]
  recursive true
  action :create
end

remote_file node["urbanterror"]["archive"]["path"] do
  source node["urbanterror"]["archive"]["source"] % {version: node["urbanterror"]["version"]}
  checksum node["urbanterror"]["archive"]["checksum"]
  action :create_if_missing
end

apt_package "unzip" do
  action :upgrade
end

execute "extract urt archive" do
  command "unzip #{node["urbanterror"]["archive"]["path"]} -d #{Chef::Config[:file_cache_path}"
  creates Chef::Config[:file_cache_path] + "/UrbanTerror42/q3ut4/zUrT42_qvm.pk3"
  action :run
end

execute "move urt files" do
  command "mv #{Chef::Config[:file_cache_path}/UrbanTerror42 #{node["urbanterror"]["dir"]}"
  creates node["urbanterror"]["dir"] + "/UrbanTerror42/q3ut4/zUrT42_qvm.pk3"
  action :run
end

execute "chown urt directory" do
  command "chown -R #{node["urbanterror"]["user"]}:#{node["urbanterror"]["group"]} #{node["urbanterror"]["dir"]}"
  only_if { Etc.getpwuid(File.stat(node["urbanterror"]["dir"]).uid) != node["urbanterror"]["user"] }
  action :run
end

template "/etc/init/urbanterror.conf" do
  source "urbanterror.conf.erb"
  mode 00644
  verify "/bin/init-checkconf %{path}"
  action :create
end
