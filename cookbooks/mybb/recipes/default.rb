#
# Cookbook:: mybb
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

template node['mybb']['schema_file'] do
  source 'schema.sql.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

include_recipe "mybb::db_schema"

directory node['mybb']['deployment_path'] do
  recursive true
  action :delete
end

directory node['mybb']['deployment_path'] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

remote_file node['mybb']['temporary_artifact'] do
  source node['mybb']['download_path']
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

bash 'extract' do
  cwd '/tmp'
  code <<-EOH
    unzip #{node['mybb']['temporary_artifact']}
    cp -r #{node['mybb']['upload_folder']}/* #{node['mybb']['deployment_path']}
    chmod 666 #{node['mybb']['deployment_path']}/inc/languages/english/*.php #{node['mybb']['deployment_path']}/inc/languages/english/admin/*.php
    chmod 777 #{node['mybb']['deployment_path']}/cache/ #{node['mybb']['deployment_path']}/cache/themes/ #{node['mybb']['deployment_path']}/uploads/ #{node['mybb']['deployment_path']}/uploads/avatars/
    chmod 777 #{node['mybb']['deployment_path']}/cache/ #{node['mybb']['deployment_path']}/cache/themes/ #{node['mybb']['deployment_path']}/uploads/ #{node['mybb']['deployment_path']}/uploads/avatars/ #{node['mybb']['deployment_path']}/admin/backups/
    EOH
  only_if { ::File.exist?(node['mybb']['temporary_artifact']) }
end


template "#{node['mybb']['deployment_path_inc']}/settings.php" do
  source 'settings.php.erb'
  owner 'root'
  group 'root'
  mode '0666'
  action :create
end

template "#{node['mybb']['deployment_path_inc']}/config.php" do
  source 'config.php.erb'
  owner 'root'
  group 'root'
  mode '0666'
  action :create
end

service "httpd" do
  action [:enable, :restart]
end

bash 'finalize' do
  code <<-EOH
    curl -X POST -F 'action=templates' http://localhost/install/index.php
    curl -X POST -F 'action=final' -F 'adminuser=admin' -F 'adminpass=admin' \
     -F 'adminpass2=admin' -F 'adminemail=admin@company.com' http://localhost/install/index.php
    EOH
end

directory "#{node['mybb']['deployment_path']}/install" do
  recursive true
  action :delete
end

service "httpd" do
  action [:reload]
end
