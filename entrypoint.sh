#!/bin/bash

echo "Running Certbot"

certbot certonly --nginx --non-interactive --agree-tos \
  --domain $CERTBOT_DOMAIN --email $CERTBOT_EMAIL --cert-name latest

echo "Starting Server"

exec "$@"
