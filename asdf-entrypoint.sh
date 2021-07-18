#!/usr/bin/env bash

if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
	source $HOME/.asdf/asdf.sh
fi

set -- docker-entrypoint.sh "$@"

exec "$@"
