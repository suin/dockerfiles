# suin/php533

Legacy PHP environment with CentOS 6.9 and PHP 5.3.3.

## Installed modules

```
bz2
calendar
Core
ctype
curl
date
ereg
exif
fileinfo
filter
ftp
gd
gettext
gmp
hash
iconv
json
libxml
mbstring
mysql
mysqli
openssl
pcntl
pcre
PDO
pdo_mysql
pdo_pgsql
pdo_sqlite
pgsql
Phar
readline
Reflection
session
shmop
SimpleXML
sockets
SPL
sqlite3
standard
tokenizer
xml
zip
zlib
```

## How to install PECL extensions

This an example of installing ssh2 extension.

```
FROM suin/php533

RUN yum install -y \
        gcc \
        php-devel \
        php-pear \
        libssh2 \
        libssh2-devel && \
    yes "" | pecl install ssh2 && \
    echo "extension=ssh2.so" > /etc/php.d/ssh2.ini && \
    yum remove -y \
        gcc \
        php-devel \
        php-pear \
        libssh2-devel && \
    yum clean all
```

Breaking down the code above, you have to install build tools at first:

```
yum install gcc php-devel php-pear
```

Install libraries which extensions want:

```
yum install libssh2-devel
```

Install extensions via `pecl` command. `yes ""` is to disable shell interactions:

```
yes "" | pecl install ssh2
```

Add extension loading statement into ini file. This PHP environment scans /etc/php.d/, so you may create new ini file there instead of rewriting php.ini directly.

```
echo "extension=ssh2.so" > /etc/php.d/ssh2.ini
```
