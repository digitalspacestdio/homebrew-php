FROM digitalspacestdio/linuxbrew as builder
LABEL maintainer="Sergey Cherepanov <s@cherepanov.co>"
LABEL name="digitalspacestdio/php"
ARG DEBIAN_FRONTEND=noninteractive
ARG BREW_FORMULA=digitalspacestdio/php/php70
ARG HOMEBREW_NO_INSTALL_CLEANUP=1
ARG HOMEBREW_NO_AUTO_UPDATE=1
ARG HOMEBREW_NO_ANALYTICS=1

RUN brew tap digitalspacestdio/php

RUN brew install --only-dependencies ${BREW_FORMULA}
RUN brew install ${BREW_FORMULA}
RUN brew install ${BREW_FORMULA}-intl ${BREW_FORMULA}-mcrypt ${BREW_FORMULA}-apcu ${BREW_FORMULA}-opcache ${BREW_FORMULA}-tidy ${BREW_FORMULA}-imagick
RUN brew install ${BREW_FORMULA}-pdo-pgsql ${BREW_FORMULA}-mongodb ${BREW_FORMULA}-redis
RUN brew install ${BREW_FORMULA}-xhprof ${BREW_FORMULA}-memprof ${BREW_FORMULA}-xdebug
RUN brew install node
RUN brew install yarn
RUN brew install composer

# Cleanup
RUN brew list | grep 'perl\|berkeley-db\|python@2\|autoconf' | xargs --no-run-if-empty brew remove; \
    rm -rf /home/linuxbrew/.cache/Homebrew; \
    brew cleanup; \
    rm -rf /home/linuxbrew/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby

FROM digitalspacestdio/debian
RUN useradd -m -s /bin/bash linuxbrew
USER linuxbrew
WORKDIR /home/linuxbrew
ENV PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH \
    SHELL=/bin/bash \
    HOMEBREW_NO_AUTO_UPDATE=1 \
    HOMEBREW_NO_INSTALL_CLEANUP=1
COPY --from=builder --chown=linuxbrew:linuxbrew /home/linuxbrew /home/linuxbrew
