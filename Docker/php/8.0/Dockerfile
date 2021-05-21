FROM digitalspacestudio/linuxbrew:latest
LABEL maintainer="Sergey Cherepanov <sergey@digitalspace.studio>"
LABEL name="digitalspacestudio/php"
ARG DEBIAN_FRONTEND=noninteractive
ARG BREW_FORMULA=digitalspacestdio/php/php80
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
RUN brew tap digitalspacestdio/common
RUN brew tap digitalspacestdio/php
RUN brew install ${BREW_FORMULA}-common
RUN brew install ${BREW_FORMULA}-xhprof ${BREW_FORMULA}-xdebug
RUN brew install composer
RUN brew install composer@1.10

# Cleanup
RUN brew list | grep 'perl\|python@2\|autoconf\|binutils\|gcc' | xargs --no-run-if-empty brew uninstall --ignore-dependencies \
    && brew cleanup \
    && rm -rf /home/linuxbrew/.cache/Homebrew \
    && rm -rf /home/linuxbrew/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby

USER root
RUN apt remove -yqq build-essential systemtap-sdt-dev make uuid-runtime pkg-config && apt autoremove -y \
    && apt-get clean \
    && rm -rf /var/cache/apt \
    && rm -rf /var/lib/apt/lists/*

USER linuxbrew