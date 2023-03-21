require "formula"
require File.expand_path("../../Abstract/abstract-php-version", __FILE__)

class Php80Common < Formula
  include AbstractPhpVersion::Php80Defs
  desc "PHP Version #{PHP_VERSION} (Common Package)"
  version PHP_VERSION
  revision 23

  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  option "with-supervisor", "Build with supervisor support"
  if build.with?("supervisor")
    depends_on "digitalspacestdio/common/digitalvisor"
  end

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
  # depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-ioncubeloader"

  # keg_only "this package contains dependency only"

  def fetch
    if OS.mac?
      system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]$' | xargs -I{} printf '{} ' | xargs #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
    elsif OS.linux?
      system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]$' | xargs -I{} printf '{} ' | xargs --no-run-if-empty #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
    end
  end

  def config_path_php
      etc / "php" / "#{PHP_VERSION}" / "php.ini"
  end

  def config_path_php_fpm
      etc / "php" / "#{PHP_VERSION}" / "php-fpm.conf"
  end

  def config_path_php_fpm_www
      etc / "php" / "#{PHP_VERSION}" / "php-fpm.d" / "www.conf"
  end

  def log_dir
      var / "log"
  end

  def supervisor_config_dir
      etc / "digitalvisor.d"
  end

  def supervisor_config_path
      supervisor_config_dir / "php#{PHP_BRANCH_NUM}-fpm.ini"
  end

  def nginx_config_dir
      etc / "nginx" / "php.d"
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

  def nginx_snippet_file
     <<~EOS
        if (-f $documentRoot/.php#{PHP_BRANCH_NUM}) {
          set $php_version #{PHP_BRANCH_NUM};
        }
     EOS
  rescue StandardError
      nil
  end

  def config_file
      <<~EOS
        [program:php#{PHP_BRANCH_NUM}]
        command=#{HOMEBREW_PREFIX}/opt/php#{PHP_BRANCH_NUM}/sbin/php-fpm --nodaemonize --fpm-config #{HOMEBREW_PREFIX}/etc/php/#{PHP_VERSION}/php-fpm.conf
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

  def binary_wrapper_path
    buildpath / "bin" / "php#{PHP_BRANCH_NUM}"
  end

  def binary_wrapper
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
            s.sub!(/^.*?short_open_tag\s*=.+$/, "short_open_tag = off")
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
            s.sub!(/^.*?listen\s*=.+$/, "listen = 127.0.0.1:90#{PHP_BRANCH_NUM}")
        end
    rescue StandardError
        nil
    end

    # prefix.install "installed.txt"
    binary_wrapper_path.write(binary_wrapper)
    binary_wrapper_path.chmod(0755)
    bin.install "bin/php#{PHP_BRANCH_NUM}"
    log_dir.mkpath
    if build.with? "supervisor"
      if config_file
        supervisor_config_dir.mkpath
        File.delete supervisor_config_path if File.exist?(supervisor_config_path)
        supervisor_config_path.write(config_file)
      end
    end

    if nginx_snippet_file
        nginx_config_dir.mkpath
        File.delete nginx_config_path if File.exist?(nginx_config_path)
        nginx_config_path.write(nginx_snippet_file)
    end
  end
end
