FROM ubuntu:latest

RUN apt update && \
    apt install --yes \
    apache2-utils \
    nginx-extras

COPY nginx.conf entrypoint.sh /

RUN chmod +x entrypoint.sh && \
    mv nginx.conf /etc/nginx/nginx.conf && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["nginx", "-g", "daemon off;"]
