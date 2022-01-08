FROM ${FROM_IMAGE_BUILDER} AS builder
LABEL maintainer="Sergey Cherepanov <sergey@digitalspace.studio>"
LABEL name="digitalspacestudio/php"
ARG DEBIAN_FRONTEND=noninteractive
ARG BREW_FORMULA_PHP=digitalspacestdio/php/php80
ARG HOMEBREW_NO_INSTALL_CLEANUP=1
ARG HOMEBREW_NO_AUTO_UPDATE=1
ARG HOMEBREW_NO_ANALYTICS=1
ARG HOMEBREW_FORCE_BREWED_CURL=1
ARG HOMEBREW_FORCE_BREWED_GIT=1

# Install mysql client
RUN brew-build-recursive mysql-client
RUN brew link -f mysql-client

# Install msmtp
RUN brew-build-recursive install msmtp

# Install php
RUN brew tap digitalspacestdio/common
RUN brew tap digitalspacestdio/php

RUN brew-build-recursive ${BREW_FORMULA_PHP}-common
RUN brew-build-recursive ${BREW_FORMULA_PHP}-xdebug
RUN brew-build-recursive ${BREW_FORMULA_PHP}-xhprof
RUN mkdir -p $(brew --prefix)/etc/php && ln -s $(brew --prefix)/etc/php/$($(brew --prefix digitalspacestdio/php/php80)/bin/php -v | egrep -o 'PHP [0-9][0-9]*\.[0-9][0-9]*\.[0-9][A-z0-9]*' | egrep -o '[0-9][0-9]*\.[0-9][0-9]*') $(brew --prefix)/etc/php/current
RUN mkdir -p $(brew --prefix)/var/log/php && ln -s $(brew --prefix)/var/log/php/$($(brew --prefix digitalspacestdio/php/php80)/bin/php -v | egrep -o 'PHP [0-9][0-9]*\.[0-9][0-9]*\.[0-9][A-z0-9]*' | egrep -o '[0-9][0-9]*\.[0-9][0-9]*') $(brew --prefix)/var/log/php/current
RUN brew-build-recursive install composer@2.2
RUN brew-build-recursive install composer@1.10

# Cleanup
RUN brew-clean-build-recursive ${BREW_FORMULA_PHP}-common \
    && brew-clean-build-recursive ${BREW_FORMULA_PHP}-xdebug \
    && brew-clean-build-recursive ${BREW_FORMULA_PHP}-xhprof \
    && brew-clean-build-recursive composer@2.2 \
    && brew-clean-build-recursive composer@1.10

# Finilize
FROM ${FROM_IMAGE}
RUN rm -rf /home/linuxbrew/.linuxbrew
COPY --from=builder --chown=linuxbrew:linuxbrew /home/linuxbrew/.linuxbrew /home/linuxbrew/.linuxbrew
