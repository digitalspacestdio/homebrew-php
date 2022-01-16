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
RUN useradd -m -s /bin/bash linuxbrew
USER linuxbrew
COPY --from=php --chown=linuxbrew:linuxbrew /home/linuxbrew/.linuxbrew/ /home/linuxbrew/.linuxbrew/
RUN echo 'export PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"' >> /home/linuxbrew/.profile
ENV PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH \
    SHELL=/bin/bash \
    LANG=en_US.UTF-8 \
    EDITOR=micro \
    HOMEBREW_NO_AUTO_UPDATE=1 \
    HOMEBREW_NO_ENV_HINTS=1 \
    HOMEBREW_NO_INSTALL_CLEANUP=1 \
    HOMEBREW_FORCE_BREWED_CURL=1 \
    HOMEBREW_FORCE_BREWED_GIT=1
WORKDIR /home/linuxbrew
SHELL ["/bin/bash", "-c"]
CMD ["bash"]

