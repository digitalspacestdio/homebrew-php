require "formula"

class PhpCliWrapper < Formula
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version "0.1.3"

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php-cli-wrapper"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8cf415d2c810f0c139ffe304e5f53022d44f59767bf2370098c4e82017129e6b"
    sha256 cellar: :any_skip_relocation, sonoma:        "51189810fb09959c18288adab531e4808be6b8ef7b3b1f6cdc819cf4f0f5d905"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4e21c9753d9d037221cbe8c7d9928058e0c4a46772235262e36a54cb2d9d475"
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
        fi
      fi

      if [[ ! -z $PHP_RC_PATH ]]; then
        PHP_VERSION=$(cat $PHP_RC_PATH | head -1 | grep -o '[0-9]\\.[0-9]') || {
          >&2  echo "Incorrect PHP version in the file: ${PHP_RC_PATH}"
          exit 1
        }
      else
        PHP_DIR=$(brew --prefix $(brew list 2>/dev/null | grep -o 'php[0-9]\\{2\\}$' | sort | tail -1))
        PHP_BIN="${PHP_DIR}/bin/php"
        if [[ -z ${PHP_DIR} ]] || [[ ! -d "${PHP_DIR}" ]] || [[ ! -e ${PHP_BIN} ]]; then
          >&2 echo "Can't find any installed php version!"
          exit 1
        fi
        PHP_VERSION=$(${PHP_DIR}/bin/php --version 2>/dev/null | grep -o '^PHP [0-9]\\.[0-9]\\.[0-9]' | grep -o '[0-9]\\.[0-9]' 2>/dev/null)
      fi

      if [[ -z $PHP_VERSION ]]; then
        >&2 echo "Can't determine a php version!"
        exit 1
      fi

      PHP_VER=$(echo $PHP_VERSION | awk -F. '{ print $1$2 }')
      PHP_EXECUTABLE=$(brew --prefix php${PHP_VER})/bin/php

      if [[ -z $PHP_EXECUTABLE ]] || [[ ! -e "$PHP_EXECUTABLE" ]] > /dev/null 2>&1; then
        >&2 echo "Cant find a php executable for the version: $PHP_VERSION"
        >&2 echo "You can try to install it by following command: brew install ${PHP_EXECUTABLE}-common"
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
