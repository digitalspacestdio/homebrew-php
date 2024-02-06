# encoding: utf-8
require "formula"
require File.expand_path("../../Abstract/abstract-php-version", __FILE__)

class AbstractPhpCommon < Formula  
  # def @@php_version
  #   raise "Unspecified php version"
  # end

  # def @@php_version_path
  #   raise "Unspecified php version path"
  # end

  def self.init (php_version, php_version_full, php_version_path)
    @@php_version = php_version
    @@php_version_full = php_version_full
    @@php_version_path = php_version_path

    desc "PHP Version #{@@php_version_full} (Common Package)"
    url "file:///dev/null"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    version php_version_full
    revision 26

    depends_on "digitalspacestdio/php/php#{@@php_version_path}"
    depends_on "digitalspacestdio/php/php#{@@php_version_path}-apcu"
    depends_on "digitalspacestdio/php/php#{@@php_version_path}-gmp"
    depends_on "digitalspacestdio/php/php#{@@php_version_path}-igbinary"
    depends_on "digitalspacestdio/php/php#{@@php_version_path}-intl"
    depends_on "digitalspacestdio/php/php#{@@php_version_path}-mongodb"
    depends_on "digitalspacestdio/php/php#{@@php_version_path}-opcache"
    depends_on "digitalspacestdio/php/php#{@@php_version_path}-pdo-pgsql"
    depends_on "digitalspacestdio/php/php#{@@php_version_path}-sodium"
    depends_on "digitalspacestdio/php/php#{@@php_version_path}-redis"
    depends_on "digitalspacestdio/php/php#{@@php_version_path}-tidy"
    depends_on "digitalspacestdio/php/php#{@@php_version_path}-zip"
    depends_on "digitalspacestdio/php/php#{@@php_version_path}-ldap"
    depends_on "digitalspacestdio/php/php#{@@php_version_path}-xdebug"
    # depends_on "digitalspacestdio/php/php#{@@php_version_path}-ioncubeloader"

    # keg_only "this package contains dependency only"
  end

  def fetch
    if OS.mac?
      system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]$' | xargs -I{} printf '{} ' | xargs #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
      #system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]-common$' | xargs -I{} printf '{} ' | xargs #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
    elsif OS.linux?
      system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]$' | xargs -I{} printf '{} ' | xargs --no-run-if-empty #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
      #system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]-common$' | xargs -I{} printf '{} ' | xargs --no-run-if-empty #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
    end
  end

  def config_path_php
      etc / "php" / "#{@@php_version}" / "php.ini"
  end

  def config_path_phprc
    etc / "php" / ".phprc"
  end

  def config_path_php_fpm
      etc / "php" / "#{@@php_version}" / "php-fpm.conf"
  end

  def config_path_php_fpm_www
      etc / "php" / "#{@@php_version}" / "php-fpm.d" / "www.conf"
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
    buildpath / "bin" / "php#{@@php_version_path}"
  end

  def binary_versioned_wrapper
    <<~EOS
      #!/usr/bin/env bash
      export PATH="#{HOMEBREW_PREFIX}/opt/php#{@@php_version_path}/bin:$PATH"
      
      exec php "$@"
    EOS
  rescue StandardError
      nil
  end

  def install
    # prefix.install "installed.txt"

    binary_dir.mkpath
    binary_versioned_path.write(binary_versioned_wrapper)
    binary_versioned_path.chmod(0755)
    bin.install binary_versioned_path
  end

  def post_install
    log_dir.mkpath
    system "echo #{config_path_php}"

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
            s.sub!(/^.*?listen\s*=.+$/, "listen = #{var}/run/php#{@@php_version}-fpm.sock")
        end
    rescue StandardError
        nil
    end

    if !File.exist?(config_path_phprc) || Gem::Dependency.new('', "> " + config_path_phprc.read).match?('', @@php_version)
      config_path_phprc.write(@@php_version)
    end
  end
end
