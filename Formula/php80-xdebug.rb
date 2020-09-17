require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Xdebug < AbstractPhp80Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://github.com/xdebug/xdebug/tarball/d31773795d7184f16e592ae865bec1fb329aeb69"
  sha256 "1f3e6a69ed1e69d56ddc6a19ff7b13735ac5ffdfe96445c79e5dea93e8e2984a"
  head "https://github.com/xdebug/xdebug.git"
  version "3.0.0"
  revision 1

  def extension_type
    "zend_extension"
  end

  def install
    #Dir.chdir "xdebug-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make clean"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end
end
