FROM digitalspacestudio/linuxbrew:latest AS builder
LABEL maintainer="Sergey Cherepanov <sergey@digitalspace.studio>"
LABEL name="digitalspacestudio/php"
ARG DEBIAN_FRONTEND=noninteractive
ARG PHP_VERSION=7.3
ARG BREW_FORMULA=digitalspacestdio/php/php73
ARG HOMEBREW_NO_INSTALL_CLEANUP=1
ARG HOMEBREW_NO_AUTO_UPDATE=1
ARG HOMEBREW_NO_ANALYTICS=1
ARG HOMEBREW_FORCE_BREWED_CURL=1
ARG HOMEBREW_FORCE_BREWED_GIT=1

## Install gcc
USER root
RUN apt update && apt install -yqq build-essential systemtap-sdt-dev make uuid-runtime
USER linuxbrew

# Install php
RUN brew tap digitalspacestdio/common
RUN brew tap digitalspacestdio/php
RUN brew install ${BREW_FORMULA}-common
RUN brew install ${BREW_FORMULA}-xhprof ${BREW_FORMULA}-xdebug
RUN mkdir -p $(brew --prefix)/etc/php && ln -s $(brew --prefix)/etc/php/${PHP_VERSION} $(brew --prefix)/etc/php/current
RUN mkdir -p $(brew --prefix)/var/log/php && ln -s $(brew --prefix)/var/log/php/${PHP_VERSION} $(brew --prefix)/var/log/php/current
RUN brew install composer
RUN brew install composer@1.10
RUN brew install msmtp
RUN brew install node
RUN brew install mysql-client && brew link -f mysql-client
RUN npm install --global yarn

# Cleanup
RUN brew list | grep 'perl\|python@2\|autoconf\|binutils\|gcc' | xargs --no-run-if-empty brew uninstall --ignore-dependencies \
    && brew cleanup \
    && rm -rf /home/linuxbrew/.cache/Homebrew \
    && rm -rf /home/linuxbrew/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby

FROM digitalspacestudio/linuxbrew:latest
COPY --from=builder --chown=linuxbrew:linuxbrew /home/linuxbrew/ /home/linuxbrew/
