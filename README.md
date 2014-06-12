# [S3FS](https://code.google.com/p/s3fs/)

## Overview

A Chef cookbook for S3FS.

FUSE-based file system backed by Amazon S3. Mount a bucket as a local file system read/write. Store files/folders natively and transparently.

### Eventual Consistency
Due to S3's "eventual consistency" limitations file creation can and will occasionally fail. Even after a successful create subsequent reads can fail for an indeterminate time, even after one or more successful reads. Create and read enough files and you will eventually encounter this failure. This is not a flaw in s3fs and it is not something a FUSE wrapper like s3fs can work around. The retries option does not address this issue. Your application must either tolerate or compensate for these failures

# Lightweight Resources and Providers (LWRP)

## s3fs

Perform mounting or unmounting of an Amazon Web Services S3 bucket.

- Bucket and mountpoint must be provided.
- Directory for mount point must exist.

### Parameters:

* named paramter - The Amazon S3 bucket you wish to mount
* mount - Filesystem directory to mount Amazon S3 bucket
* aws_access_key - Amazon API access key
* aws_secret_key - Amazon API secret key
* url - Amazon S3 URL. Default is "https://s3.amazonaws.com" to utilize SSL. Change to "http://s3.amazonaws.com" for non-SSL.
* use_cache - Local folder to use for local file cache. Default is "" meaning cache is disabled
* readwrite_timeout - Time to wait between read/write activity before giving up. Default is 30 seconds.
* connect_timeout - Time to wait for connection before giving up. Default is 10 seconds.
* max_stat_cache_size - Maximum number of entries in the stat cache. Default is 10000 entries or about 4MB
* action - Action to perform. Default is mount. The other option is unmount.

### Examples:

Mount Amazon S3 bucket at specified mount point. Ideally, aws_access_key and aws_secret_key would come from an encrypted data bag.

    s3fs "S3-Bucket" do
      mount "/buckets/amazon-s3-bucket"
      aws_access_key "AKIAGHQTHAHTBARGQASA"
      aws_secret_key "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"
      action :mount
    end


# License and Authors

[Christian Vozar](https://twitter.com/christianvozar) <christian@rogueethic.com>

Copyright 2014, Rogue Ethic, LLC.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
