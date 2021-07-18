FROM docker:20.10-git

ARG asdf_plugins="nodejs python ruby"

RUN apk add --no-cache \
		bash \
		curl \
		gnupg

SHELL ["/bin/bash", "-c"]

RUN git clone https://github.com/asdf-vm/asdf.git /root/.asdf && \
	source $HOME/.asdf/asdf.sh && \
	for p in $asdf_plugins; do asdf plugin add $p; done

COPY asdf-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["asdf-entrypoint.sh"]
