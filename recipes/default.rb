# Author:: Christian Vozar <christian@rogueethic.com>
# Cookbook Name:: s3fs
# Recipe:: default
#
# Copyright 2014, Rogue Ethic, LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'apt'
include_recipe 'build-essential'
include_recipe 'fuse'

case node['platform_family']
when 'debian'
  %w( mime-support libcurl4-openssl-dev libxml2-dev ).each do |dependencies|
  package dependencies
end
when 'rhel'
  %w( openssl-devel libxml2-devel curl-devel ).each do |dependencies|
  package dependencies
  end
end

remote_file "#{Chef::Config[:file_cache_path]}/s3fs-#{node["s3fs"]["version"]}.tar.gz" do
  checksum node["s3fs"]["checksum"]
  source "http://s3fs.googlecode.com/files/s3fs-#{node['s3fs']['version']}.tar.gz"
  mode '0644'
end

# -rpath directive required else s3fs will utilize FuSE libraries in /lib.
bash "Install S3FS v#{node['s3fs']['version']}" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
  export LDFLAGS=-Wl,-rpath=\$$LIB:/usr/local/lib
  tar -zxvf s3fs-#{node["s3fs"]["version"]}.tar.gz
  cd s3fs-#{node["s3fs"]["version"]}
  ./configure
  make clean && make && make install
  EOF
  not_if 'which s3fs'
end
