#
# Cookbook:: mybb
# Recipe:: db_schema
#
# Copyright:: 2017, The Authors, All Rights Reserved.

dbuser = node['mybb']['dbuser']
dbpass = node['mybb']['dbpass']
dbhost = node['mybb']['dbhost']
dbport = node['mybb']['dbport']
dbname = node['mybb']['dbname']
schema_file = node['mybb']['schema_file']

bash 'set_schema' do
  cwd '/tmp'
  code <<-EOH
    mysql --user=#{dbuser} --password=#{dbpass} --host=#{dbhost} --port=#{dbport} --database=#{dbname} < #{schema_file} || echo "Schema Already Exists"
    EOH
  only_if { ::File.exist?(node['mybb']['schema_file']) }
end

