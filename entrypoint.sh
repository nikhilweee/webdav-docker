#!/bin/bash

echo "Running Certbot"

# Disable TLS on nginx conf
mv nginx-http.conf /etc/nginx/nginx.conf
mv index.html /var/www/html

# Run certbot
certbot certonly --nginx --non-interactive --agree-tos \
  --domain $CERTBOT_DOMAIN --email $CERTBOT_EMAIL --cert-name latest

# Re-enable TLS on nginx conf
mv nginx-webdav.conf /etc/nginx/nginx.conf

# Create webdav password
htpasswd -b -c /etc/nginx/webdav.htpasswd \
  $WEBDAV_USER $WEBDAV_PASS > /dev/null 2>&1

echo "Starting Server"

exec "$@"
