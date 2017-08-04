#
# Cookbook:: nginx-reverse-proxy
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#
execute 'YUM update ' do
        command <<-SHASHANK
                sudo yum update -y
        SHASHANK
end

%w{epel-release nginx}.each do |pkg|
  package pkg do
    action :install
  end
end

template 'Changes in Nginx Configuration File' do
        path '/etc/nginx/nginx.conf'
        source 'nginx.conf.erb'
        owner 'root'
        group 'root'
        mode '0755'
end

execute 'Starting Nginx Service' do
        command <<-SHASHANK
                sudo systemctl start nginx
                sudo systemctl restart nginx
                sudo systemctl enable nginx
        SHASHANK
end

execute 'Applying firewall' do
        command <<-SHASHANK
		sudo systemctl start firewalld.service
		sudo systemctl enable firewalld.service
		firewall-cmd --permanent --add-service=http
		firewall-cmd --reload
        SHASHANK
end
