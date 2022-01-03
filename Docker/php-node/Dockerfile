FROM digitalspacestudio/linuxbrew:latest AS builder
LABEL maintainer="Sergey Cherepanov <sergey@digitalspace.studio>"
LABEL name="digitalspacestudio/php"
ARG DEBIAN_FRONTEND=noninteractive
ARG BREW_FORMULA_PHP=digitalspacestdio/php/php80
ARG BREW_FORMULA_NODE=node
ARG HOMEBREW_NO_INSTALL_CLEANUP=1
ARG HOMEBREW_NO_AUTO_UPDATE=1
ARG HOMEBREW_NO_ANALYTICS=1
ARG HOMEBREW_FORCE_BREWED_CURL=1
ARG HOMEBREW_FORCE_BREWED_GIT=1

## Install gcc
USER root
RUN apt update && apt install -yqq build-essential systemtap-sdt-dev make uuid-runtime pkg-config
USER linuxbrew

# Install php
RUN brew install mysql-client && brew link -f mysql-client
RUN brew install msmtp
RUN brew install ${BREW_FORMULA_NODE} && npm install --global yarn
RUN brew tap digitalspacestdio/common
RUN brew tap digitalspacestdio/php
RUN brew install ${BREW_FORMULA_PHP}-common
RUN brew install ${BREW_FORMULA_PHP}-xhprof ${BREW_FORMULA_PHP}-xdebug
RUN mkdir -p $(brew --prefix)/etc/php && ln -s $(brew --prefix)/etc/php/$($(brew --prefix digitalspacestdio/php/php80)/bin/php -v | egrep -o 'PHP [0-9][0-9]*\.[0-9][0-9]*\.[0-9][A-z0-9]*' | egrep -o '[0-9][0-9]*\.[0-9][0-9]*') $(brew --prefix)/etc/php/current
RUN mkdir -p $(brew --prefix)/var/log/php && ln -s $(brew --prefix)/var/log/php/$($(brew --prefix digitalspacestdio/php/php80)/bin/php -v | egrep -o 'PHP [0-9][0-9]*\.[0-9][0-9]*\.[0-9][A-z0-9]*' | egrep -o '[0-9][0-9]*\.[0-9][0-9]*') $(brew --prefix)/var/log/php/current
RUN brew install composer
RUN brew install composer@1.10

# Cleanup
RUN brew list | grep 'perl\|python@2\|autoconf\|binutils\|gcc' | xargs --no-run-if-empty brew uninstall --ignore-dependencies \
    && brew cleanup

# Finilize
FROM digitalspacestudio/linuxbrew:latest
RUN rm -rf /home/linuxbrew/.linuxbrew
COPY --from=builder --chown=linuxbrew:linuxbrew /home/linuxbrew/.linuxbrew /home/linuxbrew/.linuxbrew
