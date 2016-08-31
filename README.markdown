# [S3FS](https://code.google.com/p/s3fs/)

## Overview

An Opscode Chef cookbook for S3FS.

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

Copyright © 2016, Rogue Ethic LLC.

Fabriqué en Nouvelle Orléans ⚜

##### Licensed under BSD 3-Clause "New" or "Revised". All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

* Neither the name of rootca nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
