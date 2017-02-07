#! /bin/sh

# exit if a command fails
set -e


apk update

# install fetchmail
apk add fetchmail

# install go-cron
apk add curl
curl -L --insecure https://github.com/odise/go-cron/releases/download/v0.0.6/go-cron-linux.gz | zcat > /usr/local/bin/go-cron
chmod u+x /usr/local/bin/go-cron

# install pip libraries
pip install dropbox pytz

# cleanup
rm -rf /var/cache/apk/*
