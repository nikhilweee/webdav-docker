FROM nginx:latest

RUN apt update && apt install --yes \
    cron python3-certbot python3-certbot-nginx

COPY nginx.conf entrypoint.sh index.html /

RUN chmod +x entrypoint.sh && \
    sed -i 's/certbot_domain/$CERTBOT_DOMAIN/g' nginx.conf && \
    mv nginx.conf /etc/nginx/nginx.conf && \
    mv index.html /usr/share/nginx/html

ENTRYPOINT [ "/entrypoint.sh" ]

# Start Nginx and Cron in the foreground
CMD ["nginx", "-g", "daemon off;"]
