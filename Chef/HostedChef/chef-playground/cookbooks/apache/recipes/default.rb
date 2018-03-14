#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
package 'apache2' do
    action :install
end


service 'apache2' do
    action [:enable, :start]
end

directory '/etc/httpd/conf.d' do
    recursive true
    action :create
end
template '/etc/httpd/conf.d/custom.conf' do
    source 'custom.erb'
    mode '0644'
    variables(
        :document_root => node['apache']['docment_root'],
        :port => node['apache']['port']
    )
    notifies :restart, 'service[apache2]'
end


document_root = node['apache']['document_root']


directory document_root do
    mode '0775'
    recursive true
end


template "#{document_root}/index.html" do
    source 'index.html.erb'
    mode '0644'
    variables(
        :message => node['motd']['message'],
        :port => node['apache']['port']
    )
end

