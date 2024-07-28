require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Xdebug < AbstractPhp84Extension
  init PHP_VERSION, false
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.4.0alpha1.tar.gz"
  sha256 "9074ca36820155b319d872db4a35dbd28741b5d35bff2610b446556f1b3a3b58"
  head "https://github.com/xdebug/xdebug.git"
  version "3.4.0alpha1"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0-100"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "92db8bc4d0a0b1535f2c1ad09eef4b51491b39118cd71450c75c822f62c6000b"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "73e6987c99a5ff41420d6a1c8f227651778131053fc8da16ddef65e41e2985f9"
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
