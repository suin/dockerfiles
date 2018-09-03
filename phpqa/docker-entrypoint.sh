#!/usr/bin/env sh
set -eu

if [ -x "$(command -v /composer/vendor/bin/$1)" ]; then
  set -- /sbin/tini -- php /composer/vendor/bin/"$@"
fi

exec "$@"
