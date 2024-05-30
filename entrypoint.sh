#!/bin/bash

echo "Creating WebDAV Password"

htpasswd -b -c /etc/nginx/webdav.htpasswd \
  $WEBDAV_USER $WEBDAV_PASS > /dev/null 2>&1

echo "Starting Server"

exec "$@"