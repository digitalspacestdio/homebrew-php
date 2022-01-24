FROM digitalspacestudio/linuxbrew:latest AS builder
LABEL maintainer="Sergey Cherepanov <sergey@digitalspace.studio>"
LABEL name="digitalspacestudio/php-node-builder"
ARG DEBIAN_FRONTEND=noninteractive
ARG HOMEBREW_NO_INSTALL_CLEANUP=1
ARG HOMEBREW_NO_AUTO_UPDATE=1
ARG HOMEBREW_NO_ANALYTICS=1
ARG HOMEBREW_FORCE_BREWED_CURL=1
ARG HOMEBREW_FORCE_BREWED_GIT=1
ARG BREW_INSTALL_ARGS="--quiet -s"
ARG BREW_FORMULAS_PHP=""
ARG BREW_FORMULAS_NODE=""
ARG BREW_FORMULAS_EXTRA=""
USER linuxbrew

# Tap
RUN brew tap digitalspacestdio/common
RUN brew tap digitalspacestdio/php
RUN brew list > ~/.brew_builder_formulas
RUN echo "$BREW_FORMULAS_PHP $BREW_FORMULAS_NODE $BREW_FORMULAS_EXTRA" > ~/.brew_builder_formulas
RUN brew-build-recursive $(brew-list-build-deps $(echo "$BREW_FORMULAS_PHP $BREW_FORMULAS_NODE $BREW_FORMULAS_EXTRA"))
RUN brew cleanup && rm -rf /home/linuxbrew/.cache/Homebrew

