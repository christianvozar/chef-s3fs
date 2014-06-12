#!/usr/bin/env bats

@test "S3FS was installed." {
  run test -f /usr/bin/s3fs
  [ "$status" -eq 0 ]
}
