#!/bin/sh
set -e

tffilechecksum=$(sha1sum ./terraform/timestamp.txt | awk '{ print $1 }')
s3filechecksum=$(sha1sum ./data/downloaded_timestamp.txt | awk '{ print $1 }')

if [ "$tffilechecksum" != "$s3filechecksum" ]; then
  echo "files are different"
  exit 1
fi

echo "files are equal"
exit 0