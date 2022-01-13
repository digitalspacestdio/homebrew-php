ARG FROM_IMAGE_BUILDER=digitalspacestudio/php-node-builder
ARG FROM_IMAGE_PHP=digitalspacestudio/php
ARG FROM_IMAGE=digitalspacestudio/linuxbrew

FROM ${FROM_IMAGE_PHP} as php
RUN php --version

FROM ${FROM_IMAGE_BUILDER} AS builder
LABEL maintainer="Sergey Cherepanov <sergey@digitalspace.studio>"
LABEL name="digitalspacestudio/php-node"
ARG DEBIAN_FRONTEND=noninteractive
ARG BREW_FORMULA_NODE_DEPS=node
ARG BREW_FORMULA_NODE=node
ARG HOMEBREW_NO_INSTALL_CLEANUP=1
ARG HOMEBREW_NO_AUTO_UPDATE=1
ARG HOMEBREW_NO_ANALYTICS=1
ARG HOMEBREW_FORCE_BREWED_CURL=1
ARG HOMEBREW_FORCE_BREWED_GIT=1
USER linuxbrew
# Copy php
RUN rm -rf /home/linuxbrew/.linuxbrew
COPY --from=php --chown=linuxbrew:linuxbrew /home/linuxbrew/.linuxbrew /home/linuxbrew/.linuxbrew

# Install node
RUN brew-build-recursive ${BREW_FORMULA_NODE}
RUN brew link --overwrite ${BREW_FORMULA_NODE}
RUN npm install --global yarn
RUN brew-clean-build-recursive ${BREW_FORMULA_NODE}

# Cleanup
RUN brew cleanup \
    && rm -rf /home/linuxbrew/.cache/Homebrew \
    && rm -rf /home/linuxbrew/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby

# Copy php
FROM ${FROM_IMAGE_PHP} as php
RUN rm -rf /home/linuxbrew/.linuxbrew
COPY --from=builder --chown=linuxbrew:linuxbrew /home/linuxbrew/.linuxbrew /home/linuxbrew/.linuxbrew

# Finilize
FROM ${FROM_IMAGE}
COPY --from=php --chown=linuxbrew:linuxbrew /home/linuxbrew/.linuxbrew/ /home/linuxbrew/.linuxbrew/

