# zotdav

Easily setup an HTTPS enabled, nginx-based WebDAV server for Zotero using
Docker. This project includes fetching TLS certificates using certbot, and
extended support for WebDAV using the `nginx-dav-ext` module.

## Setup WebDAV

1.  Store credentials in a `.env` file.

    ```bash
    # .env
    WEBDAV_USER=username
    WEBDAV_PASS=password
    CERTBOT_EMAIL=you@email.com
    CERTBOT_DOMAIN=yourdomain.com
    ```

2.  Configure mount paths on your host.

    ```yaml
    services:
    # ...
    server:
        # ...
        volumes:
        - "/path/to/webdav:/var/www/webdav"
        - "/path/to/letsencrypt:/etc/letsencrypt"
    ```
    Make sure `/path/to/webdav` and `/path/to/letsencrypt` exist on the host.

3.  Run the service using docker compose.

    ```console
    $ docker compose up -d
    ```

    To follow the logs, you can use `docker compose logs -f`

## Setup Zotero

1. Open Zotero settings. In the "Sync" section, select "Sync attachment files in
   My Library using WebDAV".
2. Enter the URL for your WebDAV server. Typically this will also your certbot
   domain.
3. Enter the username and password for your WebDAV server. You set these in the
   `.env` file.
4. Zotero will automatically append `/zotero/` to the URL you enter. If you need
   a different path, you will need to make sure that the path exists on the
   filesystem.
5. For reference, `https://yourdomain.com/webdav/path/to/zotero` will correspond
   to `/path/to/webdav/path/to/zotero` on your filesystem.

## Footnotes

1. Certbot sets up a cron job to renew certificates automatically. Certbot logs
   can be found at `/var/log/letsencrypt/letsencrypt.log`.
1. Install the `nginx-dav-ext` module using `apt install nginx-extras`. After
   installation, `nginx-dav-ext` needs to be loaded in `nginx.conf`.
1. While fetching certificate for the first time, `nginx.conf` should be valid.
   This means there cannot be any TLS servers in `nginx.conf` when certbot is
   running. This is also why this project has two configs for nginx.
1. While HTTPS is not required for WebDAV, Zotero's iPad app will refuse to
   authenticate over HTTP.
