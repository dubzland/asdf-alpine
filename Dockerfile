FROM docker:20.10-git

LABEL maintainer="jdubz@dubzland.net"

ARG asdf_plugins="elixir erlang golang nodejs python ruby"
ARG asdf_dir="/opt/asdf"
ARG asdf_data_dir="/var/lib/asdf"
ARG build_date="2022-08-23"

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date="2022-08-23"
LABEL org.label-schema.name="jdubz/asdf-alpine"
LABEL org.label-schema.description="Alpine image with asdf-vm preinstalled"
LABEL org.label-schema.vcs-url="https://git.dubzland.net/dubzland/asdf-alpine/"

ENV ASDF_DIR $asdf_dir
ENV ASDF_DATA_DIR $asdf_data_dir
ENV XDG_CACHE_HOME /work/.cache

RUN apk add --no-cache \
		bash \
		build-base \
		bzip2-dev \
		ca-certificates \
		cargo \
		curl \
		gcc \
		gnupg \
		libffi-dev \
		openssl-dev \
		readline-dev \
		rust \
		sqlite-dev \
		zlib-dev

RUN mkdir $ASDF_DIR && \
	mkdir $ASDF_DATA_DIR && \
	git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR && \
	source $ASDF_DIR/asdf.sh && \
	for p in $asdf_plugins; do asdf plugin add $p; done && \
	git config --global --add safe.directory /work

WORKDIR /work

COPY asdf-entrypoint.sh /usr/local/bin/
COPY asdf-exec.sh /usr/local/bin/

ENTRYPOINT ["asdf-entrypoint.sh"]
