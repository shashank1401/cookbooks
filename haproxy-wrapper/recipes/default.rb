#
# Cookbook:: haproxy-wrapper
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

haproxy_install 'package' do

end

haproxy_config_global '' do
  chroot '/var/lib/haproxy'
  daemon true
  maxconn 256
  log '/dev/log local0'
  log_tag 'WARDEN'
  pidfile '/var/run/haproxy.pid'
  stats socket: '/var/lib/haproxy/stats level admin'
  tuning 'bufsize' => '262144'
end

haproxy_config_defaults '' do
  mode 'http'
  timeout connect: '5000ms',
          client: '5000ms',
          server: '5000ms'
end


haproxy_frontend 'http-in' do
  bind '*:80'
  extra_options(
    'redirect' => [
      'code 301 prefix / if acl1',
      'scheme https if !acl_2'
    ])
  default_backend 'servers'
end

haproxy_backend 'servers' do
  server ['server1 www.opstree.com'] 
  server ['server2 www.facebook.com']
end

#
#service("haproxy") do
#action [:enable, :start]
#updated true
#supports {:restart=>true, :status=>true, :reload=>true}
#retries 0
#retry_delay 2
#service_name "haproxy"
#enabled true
#pattern "haproxy"
#cookbook_name "haproxy"
#recipe_name "default"
#end
##
#proxy_resolver 'dns' do
#  nameserver ['google 8.8.8.8:53']
#  extra_options('resolve_retries' => 30,
#                'timeout' => 'retry 1s')
#end
#

