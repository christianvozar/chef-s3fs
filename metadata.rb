name             's3fs'
maintainer       'Rogue Ethic, LLC.'
maintainer_email 'support@rogueethic.com'
license          'Apache v2.0'
description      'Installs/Configures S3FS, a FUSE-based file system for mounting Amazon S3.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

# Cookbook Dependancies
%w(
  apt
  build-essential
  fuse
).each do |cookbooks|
  depends cookbooks
end

# Supported Operating Systems
%w(
  debian
  ubuntu
  redhat
).each do |os|
  supports os
end
