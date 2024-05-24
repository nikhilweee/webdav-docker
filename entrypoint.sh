#!/bin/bash

echo "Running Certbot"

certbot certonly --nginx --non-interactive --agree-tos \
  --domain $CERTBOT_DOMAIN --email $CERTBOT_EMAIL --cert-name latest

echo "Creating Credentials"

htpasswd -b -c /etc/nginx/webdav.htpasswd \
  $WEBDAV_USER $WEBDAV_PASS > /dev/null 2>&1

echo "Starting Server"

exec "$@"
