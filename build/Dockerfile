FROM dockeredcom/debian-stretch-gpg

MAINTAINER Yves Vindevogel (yves.vindevogel@dockered.com)

ARG DEBIAN_FRONTEND=noninteractive

ENV DOWNLOAD_URL=http://file.zip
ENV DOWNLOAD_USER=user_blank_allowed
ENV DOWNLOAD_PASSWORD=password_blank_allowed
ENV DOWNLOAD_IGNORE_CERTIFICATE=false
ENV SHELL=/bin/bash

WORKDIR /srv

COPY ./nginx.list   /etc/apt/sources.list.d/nginx.list
COPY ./nginx.conf   /tmp/nginx.conf
COPY ./start.sh     /srv/scripts/start.sh

RUN set -x && \ 
    chmod +x /srv/scripts/start.sh && \ 
    apt-get update --yes && \ 
    apt-get upgrade --yes && \ 
    apt-get install dialog unzip --yes --no-install-recommends && \ 
    apt-get install nginx --yes --no-install-recommends && \ 
    rm -f /etc/nginx/conf.d/default.conf && \ 
    rm -f /etc/nginx/nginx.conf && \ 
    mv /tmp/nginx.conf /etc/nginx/ && \ 
    apt-get autoremove --yes && \ 
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

ENTRYPOINT ["/srv/scripts/start.sh"]
