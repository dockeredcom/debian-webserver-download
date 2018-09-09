###
#
# Yves Vindevogel
# 2018-09-09
# Version 1.0.0
#
###

FROM dockeredcom/debian-stretch-gpg

MAINTAINER Yves Vindevogel (yves.vindevogel@dockered.com)

ARG DEBIAN_FRONTEND=noninteractive

# All environment variables needed in scripts.
# Each one of these variable should be set using either an environment file
# or using environment variables.
# The variables are used in start.sh to download the sources using curl.

ENV DOWNLOAD_URL=http://file.zip
ENV DOWNLOAD_USER=user_blank_allowed
ENV DOWNLOAD_PASSWORD=password_blank_allowed
ENV DOWNLOAD_IGNORE_CERTIFICATE=false

# Standard shell variable as found everywhere.

ENV SHELL=/bin/bash

# All files go into /srv.
# It's nice when we open a shell that we are straight in /srv.

WORKDIR /srv

# Yves Vindevogel
# 2018-09-09
# By default, Debian installs version 1.10.3, whereas Nginx itselfs indicates
# that they are at 1.14.0 (stable releases). Therefore, using the packages
# provided by Nginx instead of the ones coming with Debian.

COPY ./nginx.list   /etc/apt/sources.list.d/nginx.list

# Copying the nginx config file.
# One major update in that file is that nginx is not running as daemon.
# Nginx is not running as daemon, because we use it to keep the container
# running when calling start.sh.

COPY ./nginx.conf   /tmp/nginx.conf

# Copying the start script.
# This script downloads the content and starts the webserver.

COPY ./start.sh     /srv/scripts/start.sh
# From here on, only RUN !

RUN chmod +x /srv/scripts/start.sh

# Installation of packages.

RUN apt-get update --yes
RUN apt-get upgrade --yes

# Supporting packages.

RUN apt-get install dialog unzip --yes --no-install-recommends

# Installing nginx main package (version 1.14.0).

RUN apt-get install nginx --yes --no-install-recommends

# Removing the default.conf.
# It's no longer needed, nor even included in the nginx.conf.
# Moving our own config file in.

RUN rm -f /etc/nginx/conf.d/default.conf
RUN rm -f /etc/nginx/nginx.conf
RUN mv /tmp/nginx.conf /etc/nginx/

# Default cleanup.

RUN apt-get autoremove --yes
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Default port for http.

EXPOSE 80

# Running the start script that starts nginx (not as a daemon!).
# Basically, you don't need the /bin/bash to keep the container running.
# Nginx is running and keeping the container alive.

ENTRYPOINT ["/srv/scripts/start.sh"]
