# Purpose

This image provides a webserver (Nginx) which receives its content via a download.

## 1. Flow

1. The sources are downloaded as a .zip file from the URL given using the criteria specified with the ENV variables.
2. All files are unzipped in /srv/nginx, the root directory for the webserver.
3. Nginx serves this static directory.

## 2. Current versions

- Nginx: 1.14.0.

## 3. Usage

### 3.1 Environment variables

This image has several environment variables to specify where the content is to be downloaded.

```
DOWNLOAD_URL=http://file.zip
DOWNLOAD_USER=user_blank_allowed
DOWNLOAD_PASSWORD=password_blank_allowed
DOWNLOAD_IGNORE_CERTIFICATE=false
```

##### DOWNLOAD_USER

The user used to connect to the server. The user should have read rights. You can leave this blank also.

##### DOWNLOAD_PASSWORD

The password for the user above. If DOWNLOAD_USER is blank, this one is ignored.

##### DOWNLOAD_URL

The URL of the zip file to be downloaded.
The zip file must have all files in the root of the zip, not under an extra directory.

##### DOWNLOAD_IGNORE_CERTIFICATE

If the download site is using HTTPS and you don't have the certificate installed, you can set this to "true" to ignore any SSL errors.

### 3.2 Running the container

One important note: you must specify all the environment properties as described above.

```
docker run --rm -t -d -p 80:80 --env-file /full-path-to/your-envionment-file.properties --name webserver dockeredcom/debian-webserver-download /bin/bash
```

# Support

This image is supported and maintained by Asynchrone.  Asynchrone is the owner of dockered.com (and user dockeredcom). If you have any problems, bugs or questions, please contact info@dockered.com or info@asynchrone.com. Asynchrone will provide the best support possible. However, as this is a free and open source image, Asynchrone cannot guarantee any timing, nor solution. If you want a higher level of support, you may want to consider a paid support option. Contact yves.vindevogel@asynchrone.com for paid support questions.
