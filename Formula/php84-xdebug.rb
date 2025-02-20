require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Xdebug < AbstractPhp84Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://github.com/xdebug/xdebug/archive/5107d2d978302323f9e65002fad2aee9f4c24628.tar.gz"
  sha256 "d02d1b61cba9cc018e0fc68dd3bdca33c47d99dd909e56a2f4c114fb101f1ca3"
  head "https://github.com/xdebug/xdebug.git"
  version "3.4.1"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.4-111"
    sha256 cellar: :any_skip_relocation, ventura:      "2c3d3d6eb98d220b9293f33ecfb7cb3a0cdf43875d69d9bc5e8c627a0f2e8384"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "80224d53d554e848384b343f0157f0f9f4f79995d5c342d539bee5e63700cd47"
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
