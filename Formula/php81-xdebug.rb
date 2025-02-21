require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Xdebug < AbstractPhp81Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.2.2.tar.gz"
  sha256 "505b7b3bf5f47d1b72d18f064a8becb6854b8574195ca472e6f8da00bdc951a8"
  version "3.2.2"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6dd7e9a42b96b1f98edf1550d9a2707613ed07c80828e04ea4022ed0bcc8de42"
    sha256 cellar: :any_skip_relocation, ventura:       "34c481acaafdbaacf91e55627c31c9dcff172becaec87fde14961449941b697a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "69f1cc4c2a40f83a8b53fb4eabe18d3f927bd0c6f8f1b98e3618b60c79c682db"
  end

  def extension_type
    "zend_extension"
  end

  def config_file
    <<~EOS
      [#{extension}]
      #{extension_type}="#{module_path}"
      xdebug.mode=off
      xdebug.start_with_request=trigger
      xdebug.client_host=127.0.0.1
      xdebug.client_port=9003
      xdebug.discover_client_host=false
      xdebug.remote_cookie_expire_time = 3600
      xdebug.idekey=PHPSTORM
      xdebug.max_nesting_level=512
    EOS
  rescue StandardError
    nil
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make clean"
    system "make"
    prefix.install "modules/xdebug.so"
  end

  def post_install
    write_config_file
  end
end
