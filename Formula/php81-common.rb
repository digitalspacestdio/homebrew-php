require "formula"
require File.expand_path("../../Abstract/abstract-php-version", __FILE__)

class Php81Common < Formula
  desc "PHP Version 8.1 (Common Package)"
  include AbstractPhpVersion::Php81Defs
  version PHP_VERSION
  revision 9

  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  option "with-supervisor", "Build with supervisor support"
  if build.with?("supervisor")
    depends_on "digitalspacestdio/common/digitalvisor"
  end

  depends_on "digitalspacestdio/php/php81"
  depends_on "digitalspacestdio/php/php81-apcu"
  depends_on "digitalspacestdio/php/php81-gmp"
  depends_on "digitalspacestdio/php/php81-igbinary"
  depends_on "digitalspacestdio/php/php81-intl"
  depends_on "digitalspacestdio/php/php81-mongodb"
  depends_on "digitalspacestdio/php/php81-opcache"
  depends_on "digitalspacestdio/php/php81-pdo-pgsql"
  depends_on "digitalspacestdio/php/php81-sodium"
  depends_on "digitalspacestdio/php/php81-redis"
  depends_on "digitalspacestdio/php/php81-tidy"
  depends_on "digitalspacestdio/php/php81-zip"
  depends_on "digitalspacestdio/php/php81-ldap"
  # depends_on "digitalspacestdio/php/php81-ioncubeloader"

  keg_only "this package contains dependency only"

  def fetch
    if OS.mac?
      system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]$' | xargs -I{} printf '{} ' | xargs #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
    elsif OS.linux?
      system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]$' | xargs -I{} printf '{} ' | xargs --no-run-if-empty #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
    end
  end

  def config_path_php
      etc / "php" / "8.1" / "php.ini"
  end

  def config_path_php_fpm
      etc / "php" / "8.1" / "php-fpm.conf"
  end

  def config_path_php_fpm_www
      etc / "php" / "8.1" / "php-fpm.d" / "www.conf"
  end

  def log_dir
      var / "log"
  end

  def supervisor_config_dir
      etc / "digitalvisor.d"
  end

  def supervisor_config_path
      supervisor_config_dir / "php81-fpm.ini"
  end

  def user
    ENV['USER']
  end

  def user_group
    system "id -Gn #{user}"
  end

  def config_file
      <<~EOS
        [program:php81]
        command=#{HOMEBREW_PREFIX}/opt/php81/sbin/php-fpm --nodaemonize --fpm-config #{HOMEBREW_PREFIX}/etc/php/8.1/php-fpm.conf
        directory=#{HOMEBREW_PREFIX}/opt/php81
        stdout_logfile=#{HOMEBREW_PREFIX}/var/log/php81-supervisor.log
        stdout_logfile_maxbytes=1MB
        stderr_logfile=#{HOMEBREW_PREFIX}/var/log/php81-supervisor.err
        stderr_logfile_maxbytes=1MB
        user=#{user}
        autorestart=true
        stopasgroup=true
        EOS
  rescue StandardError
      nil
  end

  def install
    system "echo $(date) > installed.txt"

    inreplace config_path_php do |s|
        s.sub!(/^.*?short_open_tag\s*=.+$/, "short_open_tag = off")
        s.sub!(/^.*?detect_unicode\s*=.+$/, "detect_unicode = off")
        s.sub!(/^.*?max_execution_time\s*=.+$/, "max_execution_time = 900")
        s.sub!(/^.*?memory_limit\s*=.+$/, "memory_limit = 4096M")
        s.sub!(/^.*?upload_max_filesize\s*=.+$/, "upload_max_filesize = 256M")
        s.sub!(/^.*?post_max_size\s*=.+$/, "post_max_size = 256M")
        s.sub!(/^.*?display_errors\s*=.+$/, "display_errors = on")
        s.sub!(/^.*?error_reporting\s*=.+$/, "error_reporting = E_ALL ^ E_DEPRECATED")
        s.sub!(/^.*?max_input_vars\s*=.+$/, "max_input_vars = 100000")
        s.sub!(/^.*?display_startup_errors\s*=.+$/, "display_startup_errors = on")
        s.sub!(/^.*?soap.wsdl_cache_ttl\s*=.+$/, "soap.wsdl_cache_ttl = 1")
    end

    inreplace config_path_php_fpm do |s|
        s.sub!(/^.*?error_log\s*=.+$/, "error_log = /dev/stdout")
    end

    inreplace config_path_php_fpm_www do |s|
        s.sub!(/^.*?user\s*=.+$/, "; user = #{user}")
        s.sub!(/^.*?group\s*=.+$/, "; group = #{user_group}")
        s.sub!(/^.*?listen\s*=.+$/, "listen = 127.0.0.1:9081")
    end

    prefix.install "installed.txt"
    log_dir.mkpath
    if build.with? "supervisor"
      if config_file
        supervisor_config_dir.mkpath
        File.delete supervisor_config_path if File.exist?(supervisor_config_path)
        supervisor_config_path.write(config_file)
      end
    end
  end
end
