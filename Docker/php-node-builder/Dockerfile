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
RUN sed -i 's/6c434a3be59f8f62425b2e3c077e785c9ce30ee5874ea1c270e843f273ba71ee/2303a6acfb6cc533e0e86e8a9d29f7e6079e118b9de3f96e07a71a11c082fa6a/g' /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/jpeg.rb
RUN sed -i 's/if Hardware::CPU.arm?/if Hardware::CPU.arm? \&\& OS.mac?/g' /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/nettle.rb
#RUN sed -i 's/https:\/\/github.com\/fxcoudert\/gcc\/archive\/refs\/tags\/gcc-11.2.0-arm-20211124.tar.gz/https:\/\/ftp.gnu.org\/gnu\/gcc\/gcc-11.2.0\/gcc-11.2.0.tar.xz/g' /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/gcc.rb
#RUN sed -i 's/d7f8af7a0d9159db2ee3c59ffb335025a3d42547784bee321d58f2b4712ca5fd/d08edc536b54c372a1010ff6619dd274c0f1603aa49212ba20f7aa2cda36fa8b/g' /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/gcc.rb
RUN brew-build-recursive ${BREW_FORMULA_DEPS}
RUN echo "${BREW_FORMULA_DEPS}" > ~/.brew_formula_deps
