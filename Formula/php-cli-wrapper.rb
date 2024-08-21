require "formula"

class PhpCliWrapper < Formula
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version "0.1.7"

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/php-cli-wrapper"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1e3d79d45b007c8c72802c5fbe8b90f9bd03c02ceffcdfec2e0f1c192a88c223"
    sha256 cellar: :any_skip_relocation, monterey:       "0fb9cd727872e202604dea3bc1f47702e5dc4225bf297be143f7555690c49948"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "104ae69ffa6ff654df2017cdf5cc43bbf71c4eedaf9a3256c89f1814a670423e"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "a98c6d31f0918f5fe48456fe33e67552b5751fb6a66fe2aca60711cd58b1b76a"
  end

  def binary_dir
    buildpath / "bin"
  end

  def binary_path
    buildpath / "bin" / "php"
  end

  def binary_versioned_path
    buildpath / "bin" / "php#{PHP_BRANCH_NUM}"
  end

  def binary_wrapper
    <<~EOS
      #!/usr/bin/env bash
      set -e
      if [[ ! -z $DEBUG ]]; then set -x; fi
      find-up () {
        path=${2-$PWD}
        while [[ "$path" != "" && ! -e "$path/$1" ]]; do
          path=${path%/*}
        done
        echo "$path"
      }

      PHP_RC_PATH=$(find-up .phprc $(pwd))

      if [[ ! -z $PHP_RC_PATH ]]; then
        PHP_RC_PATH="${PHP_RC_PATH}/.phprc"
      else
        PHP_RC_PATH=$(find-up .php-version $(pwd))
        if [[ ! -z $PHP_RC_PATH ]]; then
          PHP_RC_PATH="${PHP_RC_PATH}/.php-version"
        else
          if [[ -f #{HOMEBREW_PREFIX}/etc/php/.phprc ]]; then
            PHP_RC_PATH="#{HOMEBREW_PREFIX}/etc/php/.phprc"
          fi
        fi
      fi

      if [[ ! -z $PHP_RC_PATH ]]; then
        PHP_VERSION=$(cat $PHP_RC_PATH | head -1 | grep -o '[0-9]\\.[0-9]') || {
          >&2  echo "Incorrect PHP version in the file: ${PHP_RC_PATH}"
          exit 1
        }
      else
        PHP_FORMULA=$(#{HOMEBREW_PREFIX}/bin/brew list 2>/dev/null | grep -o 'php[0-9]\\{2\\}$' | sort | tail -1)
        PHP_DIR=$(#{HOMEBREW_PREFIX}/bin/brew --prefix $PHP_FORMULA)
        PHP_BIN="${PHP_DIR}/bin/php"
        if [[ -z $PHP_FORMULA ]] || [[ -z ${PHP_DIR} ]] || [[ ! -d "${PHP_DIR}" ]] || [[ ! -e ${PHP_BIN} ]]; then
          >&2 echo "Can't find any installed php version!"
          exit 1
        fi
        PHP_VERSION=$(${PHP_DIR}/bin/php --version | grep -o '^PHP [0-9]\\.[0-9]\\.[0-9]' | grep -o '[0-9]\\.[0-9]' 2>/dev/null)
      fi

      if [[ -z $PHP_VERSION ]]; then
        >&2 echo "Can't determine a php version!"
        exit 1
      fi

      PHP_VER=$(echo $PHP_VERSION | awk -F. '{ print $1$2 }')
      PHP_EXECUTABLE=$(#{HOMEBREW_PREFIX}/bin/brew --prefix php${PHP_VER})/bin/php

      if [[ -z $PHP_EXECUTABLE ]] || [[ ! -e "$PHP_EXECUTABLE" ]] > /dev/null 2>&1; then
        >&2 echo "Cant find a php executable for the version: $PHP_VERSION"
        >&2 echo "You can try to install it by following command: brew install php${PHP_VER}-common"
        exit 1
      fi
      
      exec ${PHP_EXECUTABLE} "$@"
    EOS
  rescue StandardError
      nil
  end

  def install
    binary_dir.mkpath
    binary_path.write(binary_wrapper)
    binary_path.chmod(0755)
    bin.install "bin/php"
  end
end
