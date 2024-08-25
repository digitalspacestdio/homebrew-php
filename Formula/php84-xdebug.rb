require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Xdebug < AbstractPhp84Extension
  init PHP_VERSION, false
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://github.com/xdebug/xdebug/archive/12adc6394adbf14f239429d72cf34faadddd19fb.tar.gz"
  sha256 "67bc7b1ec133a1a38dc9c23c892878bd2a0a308833964fccbae897b58aa6fe88"
  head "https://github.com/xdebug/xdebug.git"
  version "3.4.0alpha1"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0beta3-100"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "11c45c292983b9d45fafb4e93dc266ec346ec691ea99d5b372985d52d029e13c"
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
