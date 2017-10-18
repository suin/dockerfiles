FROM suin/php533

# Install ssh2 extension
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
