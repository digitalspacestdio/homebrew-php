require "formula"

class PhpCliWrapper < Formula
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version "0.1.0"


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
      # set -x
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
        PHP_VERSION=$(cat $PHP_RC_PATH | head -1 | grep -o '\\d.\\d') || {
          >&2  echo "Incorrect PHP version in the file: ${PHP_RC_PATH}"
          exit 1
        }
      else
        PHP_VERSION=$($(brew list 2>/dev/null | grep -o 'php[0-9]\\{2\\}$' | sort | tail -1) --version 2>/dev/null | grep -o '^PHP \\d.\\d.\\d' | grep -o '\\d.\\d' 2>/dev/null)
      fi

      if [[ -z $PHP_VERSION ]]; then
        >&2 echo "Can't determine a php version!"
        exit 1
      fi

      PHP_EXECUTABLE=php$(echo $PHP_VERSION | awk -F. '{ print $1$2 }')

      if [[ -z $PHP_EXECUTABLE ]] || ! which "$PHP_EXECUTABLE" > /dev/null 2>1; then
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
