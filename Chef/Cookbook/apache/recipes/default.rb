#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
package 'Install Apache' do
    case node[:platform]
    when 'redhat', 'centos'
        package_name 'httpd'
    when 'ubuntu', 'deiban'
        package_name 'apache2'
    end
    
    action :install
end


service 'Enable Apache' do
    case node[:platform]
    when 'redhat', 'centos'
        service_name 'httpd'
    when 'ubuntu', 'deiban'
        service_name 'apache2'
    end

    action [:enable, :start]
end


template "/var/www/html/index.html" do
    source 'index.html.erb'
    mode '0644'
end
