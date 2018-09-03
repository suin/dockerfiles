# Set defaults

ARG BASE_IMAGE="php:7.2-alpine"
ARG NAME="phpqa"
ARG VERSION="1.0.0"
ARG COMPOSER_IMAGE="composer:1.6.5"
ARG PHPCS_VERSION="3.3.0"
ARG PHP_CS_FIXER_VERSION="2.12.2"

# Use images

FROM ${COMPOSER_IMAGE} as composer

# Build image

FROM ${BASE_IMAGE}
ARG NAME
ARG VERSION
ARG COMPOSER_IMAGE
ARG PHPCS_VERSION
ARG PHP_CS_FIXER_VERSION

# Install Tini - https://github.com/krallin/tini

RUN apk add --no-cache tini

# Install Git

RUN apk add --no-cache git

# Enable Go binary - https://stackoverflow.com/questions/34729748/installed-go-binary-not-found-in-path-on-alpine-linux-docker

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

# Install Composer

COPY --from=composer /usr/bin/composer /usr/bin/composer
ENV PATH /composer/vendor/bin:${PATH}
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME "/composer"
RUN composer global require hirak/prestissimo "^0.3.7" && rm -rf /composer/cache && du -sh /composer/*

# Install QA tools

COPY composer.json /composer/

RUN composer global update && \
rm -rf /composer/cache && \
du -sh /composer/*

RUN curl -sSL http://get.sensiolabs.de/deptrac.phar -o /composer/vendor/bin/deptrac && \
chmod +x /composer/vendor/bin/deptrac

RUN curl -sSL http://get.sensiolabs.org/sami.phar -o /composer/vendor/bin/sami && \
chmod +x /composer/vendor/bin/sami

RUN apk add --no-cache graphviz && \
curl -sSL https://raw.github.com/mamuz/PhpDependencyAnalysis/v1.3.1/download/phpda.pubkey -o /composer/vendor/bin/phpda.pubkey && \
curl -sSL https://raw.github.com/mamuz/PhpDependencyAnalysis/v1.3.1/download/phpda -o /composer/vendor/bin/phpda && \
chmod +x /composer/vendor/bin/phpda

RUN curl -sSL https://github.com/haya14busa/reviewdog/releases/download/0.9.11/reviewdog_linux_amd64 -o /composer/vendor/bin/reviewdog && \
chmod +x /composer/vendor/bin/reviewdog

RUN phpcs --config-set installed_paths /composer/vendor/slevomat/coding-standard,/composer/vendor/object-calisthenics/phpcs-calisthenics-rules/src,/composer/vendor/consistence/coding-standard,/composer/vendor/bmitch/codor/src

# Add entrypoint script

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Add Ini file
COPY ./php.ini /usr/local/etc/php/conf.d/phpqa

# Package container

WORKDIR "/app"

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["ls", "/composer/vendor/bin"]
