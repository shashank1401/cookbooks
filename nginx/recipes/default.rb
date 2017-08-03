# Cookbook:: nginx
# Recipe:: default
# Opstree.com
# blog.opstree.com
apt_update 'update' do
  action :update
end

package 'nginx' do
 action :install
end

#git '/usr/share/nginx/chef' do
#   repository 'https://github.com/OpsTree/Chef.git'
#   revision 'master'
#   action :checkout
#   user 'root'
#   group 'root'
#end

directory "#{node['nginx']['webroot']}" do
  recursive true
end

template "/etc/nginx/conf.d/#{node['nginx']['conffile']}" do
  source 'nginx.conf.erb'
  variables(
    :port => "#{node['nginx']['port']}",
    :servername => "#{node['nginx']['servername']}",
    :webroot => "#{node['nginx']['webroot']}"
  )
end

template "#{node['nginx']['webroot']}/index.html" do
  source 'index.html.erb'
  variables(
    :servername => "#{node['nginx']['servername']}"
  )
end

line = "127.0.0.1 #{node['nginx']['servername']}"
 file = Chef::Util::FileEdit.new('/etc/hosts')
 file.insert_line_if_no_match(/#{line}/, line)
 file.write_file

service 'iptables' do
  action :stop
end

service 'nginx' do
 action :restart
end
