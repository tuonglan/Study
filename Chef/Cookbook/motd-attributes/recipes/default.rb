#
# Cookbook Name:: motd-attributes
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
require 'pp'

node.default['ipaddress'] = '1.1.1.1'
pp node.debug_value('ipaddress')

node.default['motd-attributes']['message'] = "It's a wonderful day today!"

pp node.debug_value('motd-attributes', 'company')
include_recipe 'motd-attributes::message'
pp node.debug_value('motd-attributes', 'company')

template 'etc/motd' do
    source 'motd.erb'
    mode '0644'
end
