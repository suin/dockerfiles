FROM docker:latest

RUN set -eux \
    && : "Install git" \
    && apk add --no-cache \
        git \
        openssh-client \
    && : "Install docker-compose" \
    && apk add --no-cache \
        python \
        python-dev \
        py-pip \
        build-base \
    && pip install --upgrade pip \
    && pip install docker-compose
