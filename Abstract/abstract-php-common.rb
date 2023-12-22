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

  def user
    ENV['USER']
  end

  def user_group
    system "id -Gn #{user}"
  end

  def binary_dir
    buildpath / "bin"
  end

  def binary_versioned_path
    buildpath / "bin" / "php#{PHP_BRANCH_NUM}"
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

    # prefix.install "installed.txt"

    binary_versioned_path.write(binary_versioned_wrapper)
    binary_versioned_path.chmod(0755)
    bin.install "bin/php#{PHP_BRANCH_NUM}"
    
    log_dir.mkpath
  end
end
