#
# Cookbook Name:: software_install
# Recipe:: default
#
# Copyright (C) 2013 Opscode, Inc.
# 
# All rights reserved - Do Not Redistribute
#


soft = data_bag('software')
soft.each do |item|
  pkg = data_bag_item('software', item)
  pkg['pkgs'].each do |pkg_name|
    package pkg_name do
      action :install
      version item['version']
    end
  end
end
