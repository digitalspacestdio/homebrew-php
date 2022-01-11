ARG FROM_IMAGE_BUILDER=digitalspacestudio/php-node-builder:latest
ARG FROM_IMAGE=digitalspacestudio/linuxbrew:latest
FROM $FROM_IMAGE_BUILDER AS builder
LABEL maintainer="Sergey Cherepanov <sergey@digitalspace.studio>"
LABEL name="digitalspacestudio/php"
ARG DEBIAN_FRONTEND=noninteractive
ARG BREW_FORMULA_PHP=digitalspacestdio/php/php80
ARG HOMEBREW_NO_INSTALL_CLEANUP=1
ARG HOMEBREW_NO_AUTO_UPDATE=1
ARG HOMEBREW_NO_ANALYTICS=1
ARG HOMEBREW_FORCE_BREWED_CURL=1
ARG HOMEBREW_FORCE_BREWED_GIT=1
USER linuxbrew

# Install mysql client
RUN brew-build-recursive mysql-client
RUN brew link -f mysql-client

# Install msmtp
RUN brew-build-recursive msmtp

#USER root
#RUN apt update && apt install -yqq
#RUN chown -R linuxbrew:linuxbrew /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps
#USER linuxbrew

# Untap repositories if exists
RUN brew tap | grep 'digitalspacestdio/common' && brew untap digitalspacestdio/common || exit 0
RUN brew tap | grep 'digitalspacestdio/php' && brew untap digitalspacestdio/php || exit 0

# Tap repositories
RUN brew tap digitalspacestdio/common
RUN brew tap digitalspacestdio/php

# Install php
RUN brew-build-recursive ${BREW_FORMULA_PHP}
RUN brew-build-recursive ${BREW_FORMULA_PHP}-common
RUN brew-build-recursive ${BREW_FORMULA_PHP}-xdebug
RUN brew-build-recursive ${BREW_FORMULA_PHP}-xhprof
RUN brew link ${BREW_FORMULA_PHP}

RUN mkdir -p $(brew --prefix)/etc/php && ln -s $(brew --prefix)/etc/php/$($(brew --prefix digitalspacestdio/php/php80)/bin/php -v | egrep -o 'PHP [0-9][0-9]*\.[0-9][0-9]*\.[0-9][A-z0-9]*' | egrep -o '[0-9][0-9]*\.[0-9][0-9]*') $(brew --prefix)/etc/php/current
RUN mkdir -p $(brew --prefix)/var/log/php && ln -s $(brew --prefix)/var/log/php/$($(brew --prefix digitalspacestdio/php/php80)/bin/php -v | egrep -o 'PHP [0-9][0-9]*\.[0-9][0-9]*\.[0-9][A-z0-9]*' | egrep -o '[0-9][0-9]*\.[0-9][0-9]*') $(brew --prefix)/var/log/php/current

RUN brew-build-recursive install composer@2.2
RUN brew-build-recursive install composer@1.10

# Cleanup
RUN brew-clean-build-recursive ${BREW_FORMULA_PHP} ${BREW_FORMULA_PHP}-common ${BREW_FORMULA_PHP}-xdebug ${BREW_FORMULA_PHP}-xdebug ${BREW_FORMULA_PHP}-xhprof \
    composer@2.2 composer@1.10 \
    mysql-client msmtp \

RUN brew cleanup \
    && rm -rf /home/linuxbrew/.cache/Homebrew \
    && rm -rf /home/linuxbrew/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby

# Finilize
FROM $FROM_IMAGE
RUN rm -rf /home/linuxbrew/.linuxbrew
COPY --from=builder --chown=linuxbrew:linuxbrew /home/linuxbrew/.linuxbrew /home/linuxbrew/.linuxbrew
