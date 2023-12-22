# encoding: utf-8
require "formula"
require File.expand_path("../../Abstract/abstract-php-version", __FILE__)

class AbstractPhpCommon < Formula
  include AbstractPhpVersion::Php83Defs
  desc "PHP Version #{PHP_VERSION} (Common Package)"
  depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}"
  depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-apcu"
  depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-gmp"
  depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-igbinary"
  depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-intl"
  depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-mongodb"
  depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-opcache"
  depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-pdo-pgsql"
  depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-sodium"
  depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-redis"
  depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-tidy"
  depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-zip"
  depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-ldap"
  depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-xdebug"
  # depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-ioncubeloader"

  # keg_only "this package contains dependency only"

  def fetch
    if OS.mac?
      system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]$' | xargs -I{} printf '{} ' | xargs #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
      system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]-common$' | xargs -I{} printf '{} ' | xargs #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
    elsif OS.linux?
      system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]$' | xargs -I{} printf '{} ' | xargs --no-run-if-empty #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
      system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]-common$' | xargs -I{} printf '{} ' | xargs --no-run-if-empty #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
    end
  end

  def formula_php
    "php#{PHP_BRANCH_NUM}"
  end

  def config_path_php
      etc / "php" / "#{PHP_VERSION_MAJOR}" / "php.ini"
  end

  def config_path_php_fpm
      etc / "php" / "#{PHP_VERSION_MAJOR}" / "php-fpm.conf"
  end

  def config_path_php_fpm_www
      etc / "php" / "#{PHP_VERSION_MAJOR}" / "php-fpm.d" / "www.conf"
  end

  def log_dir
      var / "log"
  end

  def supervisor_config_dir
      etc / "digitalspace" / "supervisor.d"
  end

  def supervisor_config_path
      supervisor_config_dir / "php#{PHP_BRANCH_NUM}-fpm.ini"
  end

  def nginx_config_dir
      etc / "digitalspace" / "nginx" / "php.d"
  end

  def nginx_config_path
      nginx_config_dir / "php#{PHP_BRANCH_NUM}.conf"
  end

  def user
    ENV['USER']
  end

  def user_group
    system "id -Gn #{user}"
  end

  def nginx_config
     <<~EOS
        if (-f $document_root/.php#{PHP_BRANCH_NUM}) {
          set $php_version #{PHP_VERSION_MAJOR};
        }
     EOS
  rescue StandardError
      nil
  end

  def supervisor_config
      <<~EOS
        [program:php#{PHP_BRANCH_NUM}]
        command=#{HOMEBREW_PREFIX}/opt/php#{PHP_BRANCH_NUM}/sbin/php-fpm --nodaemonize --fpm-config #{HOMEBREW_PREFIX}/etc/php/#{PHP_VERSION_MAJOR}/php-fpm.conf
        directory=#{HOMEBREW_PREFIX}/opt/php#{PHP_BRANCH_NUM}
        stdout_logfile=#{HOMEBREW_PREFIX}/var/log/php#{PHP_BRANCH_NUM}-supervisor.log
        stdout_logfile_maxbytes=1MB
        stderr_logfile=#{HOMEBREW_PREFIX}/var/log/php#{PHP_BRANCH_NUM}-supervisor.err
        stderr_logfile_maxbytes=1MB
        user=#{user}
        autorestart=true
        stopasgroup=true
        EOS
  rescue StandardError
      nil
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

  def binary_versioned_wrapper
    <<~EOS
      #!/usr/bin/env bash
      export PATH="#{HOMEBREW_PREFIX}/opt/php#{PHP_BRANCH_NUM}/bin:$PATH"
      
      exec php "$@"
    EOS
  rescue StandardError
      nil
  end

  def install
    begin
        inreplace config_path_php do |s|
          s.sub!(/^.*?short_open_tag\s*=.*$/, "short_open_tag = off")
          s.sub!(/^.*?max_execution_time\s*=.*$/, "max_execution_time = 900")
          s.sub!(/^.*?memory_limit\s*=.*$/, "memory_limit = 4096M")
          s.sub!(/^.*?upload_max_filesize\s*=.*$/, "upload_max_filesize = 256M")
          s.sub!(/^.*?post_max_size\s*=.*$/, "post_max_size = 256M")
          s.sub!(/^.*?display_errors\s*=.*$/, "display_errors = on")
          s.sub!(/^.*?error_reporting\s*=.*$/, "error_reporting = E_ALL ^ E_DEPRECATED")
          s.sub!(/^.*?max_input_vars\s*=.*$/, "max_input_vars = 100000")
          s.sub!(/^.*?display_startup_errors\s*=.*$/, "display_startup_errors = on")
          s.sub!(/^.*?soap.wsdl_cache_ttl\s*=.*$/, "soap.wsdl_cache_ttl = 1")
          s.sub!(/^.*?date.timezone\s*=.*$/, "date.timezone = UTC")
        end
    rescue StandardError
        nil
    end

    begin
        inreplace config_path_php_fpm do |s|
            s.sub!(/^.*?error_log\s*=.+$/, "error_log = /dev/stdout")
        end
    rescue StandardError
        nil
    end

    begin
        inreplace config_path_php_fpm_www do |s|
            s.sub!(/^.*?user\s*=.+$/, "; user = #{user}")
            s.sub!(/^.*?group\s*=.+$/, "; group = #{user_group}")
            s.sub!(/^.*?listen\s*=.+$/, "listen = #{var}/run/php#{PHP_VERSION_MAJOR}-fpm.sock ")
        end
    rescue StandardError
        nil
    end

    binary_dir.mkpath

    # prefix.install "installed.txt"
    binary_path.write(binary_wrapper)
    binary_path.chmod(0755)
    bin.install "bin/php"

    binary_versioned_path.write(binary_versioned_wrapper)
    binary_versioned_path.chmod(0755)
    bin.install "bin/php#{PHP_BRANCH_NUM}"
    
    log_dir.mkpath
    if supervisor_config
      supervisor_config_dir.mkpath
      File.delete supervisor_config_path if File.exist?(supervisor_config_path)
      supervisor_config_path.write(supervisor_config)
    end

    if nginx_config
        nginx_config_dir.mkpath
        File.delete nginx_config_path if File.exist?(nginx_config_path)
        nginx_config_path.write(nginx_config)
    end
  end
end
