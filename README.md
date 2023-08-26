# php-apache-pmwiki

This setup uses `php:8.2-apache` image, but is meant to be served by a local nginx server.

The pmwiki files should go to `./site/` directory.
Consider making an `index.php` file with the following content:

```php
<?php include_once('pmwiki.php');
```

Copy the content of `.env.example` to `.env` and edit accordingly.
The following variables are used:

- `APP_NAME` gives your application a name.
  It would also be the configuration file name under `/etc/nginx/sites-available/`, and `.conf` will be appended to the file name.
  For example if `APP_NAME=mywiki` then the config file would be `mywiki.conf`.
- `APP_DOCK_PORT` will be the port we assign to be mapped to port `80` of our app's docker container.
  It would also be the port our `nginx` configuration will use as a reverse-proxy.
- `UID` and `GID` would be your user ID and group ID (discover with `id -u` for UID and `id -g` for GID).
  This one is used so that you don't have to deal with permissions when managing files under `./site`.
  Also it is a good idea for your container's php to not run as root.
- `PMWIKI_URL` would be the url of your site.
  For example if it is meant to be accessed under `https://wiki.liecorp.id`, only fill in the `wiki.liecorp.id` part.
- `PMWIKI_CERTS_PARAMS` would be the file under `/etc/nginx/` that contains your `HTTPS` certificate nginx config block.
  For example the file might contain:

  ```
  ssl_certificate /etc/letsencrypt/live/liecorp.id-0001/fullchain.pem; 
  ssl_certificate_key /etc/letsencrypt/live/liecorp.id-0001/privkey.pem; 
  include /etc/letsencrypt/options-ssl-nginx.conf; 
  ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
  ```

  To actually obtain a certificate, you should consider using `certbot`.
  Read the manual very carefully and configure as you need them.
  You may want to consider certificate-only option for certbot.

You may need to download your own copy of [`pmwiki`](https://www.pmwiki.org/wiki/PmWiki/Download).
Extract the content to `./site` directory, and follow the installation directive.

Once everything is good and configured properly, run the following with docker compose:

```bash
# Run the container
docker compose up -d

# Shut down the container
docker compose down
```

