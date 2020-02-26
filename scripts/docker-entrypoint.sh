#! /bin/sh

set -e

for f in /docker-entrypoint.d/*.sh; do
  echo "Running $f"
  "$f"
done

exec /usr/local/bin/webhook "$@"
