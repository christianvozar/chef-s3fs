# Author:: Christian Vozar <christian@rogueethic.com>
# Cookbook Name:: s3fs
# Resource:: default
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

def whyrun_supported?
  false
end

action :mount do
  if ::Dir.exists?("#{new_resource.mountpoint}") == false
    directory "#{new_resource.mountpoint}" do
      owner 'root'
      group 'root'
      mode '0755'
      recursive true
      action :create
    end
    begin
      execute "mount-#{new_resource.mountpoint}" do
        command "/usr/local/bin/s3fs  -oallow_other #{new_resource.bucket} #{new_resource.mountpoint} -ouse_cache=#{new_resource.use_cache} -ourl=#{new_resource.url} -oreadwrite_timeout=#{new_resource.readwrite_timeout} -oconnect_timeout=#{new_resource.connect_timeout} -omax_stat_cache_size=#{new_resource.max_stat_cache_size}"
        action :run
        environment ({
          'AWSACCESSKEYID' => "#{new_resource.aws_access_key}",
          'AWSSECRETACCESSKEY' => "#{new_resource.aws_secret_key}"
        })
      end
      Chef::Log.info("S3FS: bucket[#{new_resource.bucket}] => #{new_resource.mountpoint} action mount")
    rescue
      Chef::Log.warn("S3FS: bucket[#{bucket}] action mount error")
    end
  end
  new_resource.updated_by_last_action(true)
end

action :unmount do
  if ::Dir.exists?("#{new_resource.mountpoint}")
    Chef::Log.info("S3FS: bucket[#{new_resource.bucket} => #{new_resource.mountpoint}] action unmount")
    execute "unmount-#{new_resource.mountpoint}" do
      command "umount #{new_resource.mountpoint}"
      action :run
      only_if "test -d #{new_resource.mountpoint}"
    end
  end
  new_resource.updated_by_last_action(true)
end
