FROM centos:6.9

ENV PHP_VERSION 5.3.3

RUN yum install -y \
        php \
        php-mbstring \
        php-pgsql \
        php-mysql \
        php-gd && \
    yum clean all

CMD ["php", "-a"]
