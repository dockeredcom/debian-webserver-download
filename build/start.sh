#!/bin/bash

###
#
# Yves Vindevogel
# 2018-09-09
# Version 1.0.0
#
# Download the content and unzip.
# Launch the webserver.
#
###

# Delete the directory if exists (cleanup on restart)

if [ -d "/srv/nginx" ]; then
  rm -rf /srv/nginx
fi

# Create the curl command with the possible options

command="curl "

if [ "$DOWNLOAD_IGNORE_CERTIFICATE" = "true" ]
then
  command+="-k "
fi

if [ "$DOWNLOAD_USER" != "" ]
then
  command+="-u $DOWNLOAD_USER:$DOWNLOAD_PASSWORD "
fi

command+="-o /srv/website.zip $DOWNLOAD_URL"

# Execute the curl command

$command

# Unzip the content

unzip /srv/website.zip -d /srv/nginx

# Remove the original zip file

rm -f /srv/website.zip

# We are running and halting the nginx command here.
# This prevents the script to stop, which is what we need.
# A docker container is running as long as a command is running (hence often using docker run /bin/bash).
# See: https://stackoverflow.com/questions/18861300/how-to-run-nginx-within-a-docker-container-without-halting

/usr/sbin/nginx
