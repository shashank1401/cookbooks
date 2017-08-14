
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#
#
execute 'YUM update ' do 
	command <<-SHASHANK
		sudo yum update -y
	SHASHANK
end 

%w{epel-release tomcat}.each do |pkg|
  package pkg do
    action :install
  end
end

template 'Java options that Tomcat uses when it starts' do 
	path '/usr/share/tomcat/conf/tomcat.conf'
	source 'tomcat.conf.erb'
	owner 'root'
	group 'root'
	mode '0755'
end 

execute 'Installing  Admin Packages' do 
	command 'sudo yum install tomcat-webapps tomcat-admin-webapps -y '
end

template 'Configuring Tomcat Web Management Interface' do 
	path '/usr/share/tomcat/conf/tomcat-users.xml'
	source 'tomcat-users.xml.erb'
	owner 'root'
	group 'root'
	mode '0755'
end

execute 'Installing  Online Documentation' do
	command 'sudo yum install tomcat-docs-webapp tomcat-javadoc -y'
end

execute 'Starting Tomcat' do
	command <<-SHASHANK
		sudo systemctl start tomcat
		sudo systemctl restart tomcat
		sudo systemctl enable tomcat
	SHASHANK
end
