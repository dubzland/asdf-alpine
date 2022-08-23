#!/bin/sh

set -- docker-entrypoint.sh asdf-exec.sh "$@"

exec "$@"
