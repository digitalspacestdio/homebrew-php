require "formula"
require File.expand_path("../../Abstract/abstract-php-version", __FILE__)

class Php56Common < Formula
  desc "PHP Version 5.6 (Common Package)"
  include AbstractPhpVersion::Php56Defs
  version PHP_VERSION
  revision 9

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

  def supervisor_config_dir
      etc / "digitalvisor.d"
  end

  def supervisor_config_path
      supervisor_config_dir / "php56-fpm.ini"
  end

  def config_file
      <<~EOS
        [program:php56-fpm]
        command=#{opt_prefix}/sbin/php-fpm --nodaemonize --fpm-config #{HOMEBREW_PREFIX}/etc/php/5.6/php-fpm.conf
        directory=#{opt_prefix}
        stdout_logfile=#{HOMEBREW_PREFIX}/var/log/supervisor/php56.log
        stderr_logfile=#{HOMEBREW_PREFIX}/var/log/supervisor/php56.err
        user=#{ENV.USER}
        autorestart=true
        stopasgroup=true
        EOS
  rescue StandardError
      nil
  end

  def install
    system "echo $(date) > installed.txt"
    prefix.install "installed.txt"
    if build.include? "with-supervisor"
      if config_file
        supervisor_config_dir.mkpath
        supervisor_config_path.write(config_file)
      end
    end
  end
end
