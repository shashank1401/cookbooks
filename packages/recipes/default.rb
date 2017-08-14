# Cookbook:: packages
# Recipe:: default
# Copyright:: 2017, The Authors, All Rights Reserved.

[node['packages']['package1'], node['packages']['package2'], node['packages']['package3'], node['packages']['package4'], node['packages']['package5'], node['packages']['package6'], node['packages']['package7']].each do |pkg|
 package pkg do
   action :install
 end
end

execute 'update' do
  command 'yum update'
end

