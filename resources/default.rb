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

actions :mount, :unmount
default_action :mount

attribute :bucket, :kind_of => String, :name_attribute => true
attribute :mountpoint, :kind_of => String, :required => true
attribute :aws_access_key, :kind_of => String, :regex => /^[A-Z0-9]{20}$/
attribute :aws_secret_key, :kind_of => String, :regex => /^[A-Za-z0-9\/+=]{40}$/
attribute :url, :kind_of => String, :default => 'https://s3.amazonaws.com'
attribute :use_cache, :kind_of => String, :default => ''
attribute :readwrite_timeout, :kind_of => [ String, Integer ], :default => '30'
attribute :connect_timeout, :kind_of => [ String, Integer ], :default => '10'
attribute :max_stat_cache_size, :kind_of => [ String, Integer ], :default => '10000'
