require "formula"

class PhpCliWrapper < Formula
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version "0.1.6"

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php-cli-wrapper"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e06fb292dcbf90f61f7b881b5a29687fcafb02ed99c52a143025cf4c1932cea2"
    sha256 cellar: :any_skip_relocation, monterey:      "99d0293dbe3b9414bf6fa29deacd5008cce549d70348e3d6b2f5d915217233e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9f99bd8889fae28f76600ce5f21d9a6db5f6be00a441cb99efc83d812a341a92"
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
        PHP_DIR=$(#{HOMEBREW_PREFIX}/bin/brew --prefix $(#{HOMEBREW_PREFIX}/bin/brew list 2>/dev/null | grep -o 'php[0-9]\\{2\\}$' | sort | tail -1))
        PHP_BIN="${PHP_DIR}/bin/php"
        if [[ -z ${PHP_DIR} ]] || [[ ! -d "${PHP_DIR}" ]] || [[ ! -e ${PHP_BIN} ]]; then
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
