FROM digitalspacestudio/linuxbrew:latest AS builder
LABEL maintainer="Sergey Cherepanov <sergey@digitalspace.studio>"
LABEL name="digitalspacestudio/php-node-builder"
ARG DEBIAN_FRONTEND=noninteractive
ARG BREW_FORMULA_DEPS=""
ARG HOMEBREW_NO_INSTALL_CLEANUP=1
ARG HOMEBREW_NO_AUTO_UPDATE=1
ARG HOMEBREW_NO_ANALYTICS=1
ARG HOMEBREW_FORCE_BREWED_CURL=1
ARG HOMEBREW_FORCE_BREWED_GIT=1
ARG BREW_INSTALL_ARGS="--quiet -s"

## Install gcc
USER root
RUN apt update -qqq && apt install -yqqq --no-install-recommends build-essential build-essential procps curl file git systemtap-sdt-dev
USER linuxbrew

# Install node
RUN brew tap digitalspacestdio/common
RUN brew tap digitalspacestdio/php
RUN brew-clean-build-recursive ${BREW_FORMULA_DEPS}
