#
# Cookbook:: Datadog
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


yum_repository 'datadog' do
  description "Datadog Stable repo"
  baseurl node['datadog']['repo_baseurl']
  gpgkey node['datadog']['repo_gpgkey']
  action :create
end

yum_package 'datadog-agent'

template node['datadog']['config_file'] do
  source 'datadog.conf.erb'
  owner 'dd-agent'
  group 'dd-agent'
  mode '0666'
  action :create
end

service 'datadog-agent' do
  action [:enable, :restart]
end
