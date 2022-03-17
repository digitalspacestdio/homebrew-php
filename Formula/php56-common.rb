require "formula"
require File.expand_path("../../Abstract/abstract-php-version", __FILE__)

class Php56Common < Formula
  desc "PHP Version 5.6 (Common Package)"
  include AbstractPhpVersion::Php56Defs
  version PHP_VERSION
  revision 18

  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  option "with-supervisor", "Build with supervisor support"
  if build.with?("supervisor")
    depends_on "digitalvisor"
  end

  depends_on "digitalspacestdio/php/php56"
  depends_on "digitalspacestdio/php/php56-apcu"
  depends_on "digitalspacestdio/php/php56-gmp"
  depends_on "digitalspacestdio/php/php56-igbinary"
  depends_on "digitalspacestdio/php/php56-intl"
  depends_on "digitalspacestdio/php/php56-mcrypt"
  depends_on "digitalspacestdio/php/php56-mongodb"
  depends_on "digitalspacestdio/php/php56-opcache"
  depends_on "digitalspacestdio/php/php56-pdo-pgsql"
  depends_on "digitalspacestdio/php/php56-redis"
  depends_on "digitalspacestdio/php/php56-tidy"
  # depends_on "digitalspacestdio/php/php56-ioncubeloader"

  keg_only "this package contains dependency only"

  def fetch
    if OS.mac?
      system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]$' | xargs -I{} printf '{} ' | xargs #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
    elsif OS.linux?
      system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]$' | xargs -I{} printf '{} ' | xargs --no-run-if-empty #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
    end
  end

  def config_path_php
      etc / "php" / "5.6" / "php.ini"
  end

  def config_path_php_fpm
      etc / "php" / "5.6" / "php-fpm.conf"
  end

  def php_log_dir
      var / "log"
  end

  def supervisor_config_dir
      etc / "digitalvisor.d"
  end

  def supervisor_config_path
      supervisor_config_dir / "php56-fpm.ini"
  end

  def user
    ENV['USER']
  end

  def user_group
    system "id -Gn #{user}"
  end

  def config_file
      <<~EOS
        [program:php56-fpm]
        command=#{HOMEBREW_PREFIX}/opt/php56/sbin/php-fpm --nodaemonize --fpm-config #{HOMEBREW_PREFIX}/etc/php/5.6/php-fpm.conf
        directory=#{HOMEBREW_PREFIX}/opt/php56
        stdout_logfile=#{HOMEBREW_PREFIX}/var/log/supervisor/php56.log
        stdout_logfile_maxbytes=1MB
        stderr_logfile=#{HOMEBREW_PREFIX}/var/log/supervisor/php56.err
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

    config_path_php.sub(/^.*?short_open_tag\s*=.+$/, "short_open_tag = off")
    config_path_php.sub(/^.*?detect_unicode\s*=.+$/, "detect_unicode = off")
    config_path_php.sub(/^.*?max_execution_time\s*=.+$/, "max_execution_time = 900")
    config_path_php.sub(/^.*?memory_limit\s*=.+$/, "memory_limit = 4096M")
    config_path_php.sub(/^.*?upload_max_filesize\s*=.+$/, "upload_max_filesize = 256M")
    config_path_php.sub(/^.*?post_max_size\s*=.+$/, "post_max_size = 256M")
    config_path_php.sub(/^.*?display_errors\s*=.+$/, "display_errors = on")
    config_path_php.sub(/^.*?error_reporting\s*=.+$/, "error_reporting = E_ALL ^ E_DEPRECATED")
    config_path_php.sub(/^.*?max_input_vars\s*=.+$/, "max_input_vars = 100000")
    config_path_php.sub(/^.*?display_startup_errors\s*=.+$/, "display_startup_errors = on")
    config_path_php.sub(/^.*?soap.wsdl_cache_ttl\s*=.+$/, "soap.wsdl_cache_ttl = 1")

    inreplace config_path_php_fpm do |s|
        s.sub!(/^.*?user\s*=.+$/, "; user = #{user}")
        s.sub!(/^.*?group\s*=.+$/, "; group = #{user_group}")
        s.sub!(/^.*?listen\s*=.+$/, "listen = 127.0.0.1:9056")
        s.sub!(/^.*?error_log\s*=.+$/, "error_log = /dev/stdout")
    end

    prefix.install "installed.txt"
    if build.with? "supervisor"
      if config_file
        supervisor_config_dir.mkpath
        supervisor_config_path.write(config_file) if !File.exist?(supervisor_config_path)
      end
    end
  end
end
