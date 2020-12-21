require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Xdebug < AbstractPhp80Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://github.com/xdebug/xdebug/tarball/0fb6119d53b2b086585a9de5a817e57e981dc75a"
  sha256 "c124b3c4f3041bc26581199b8d403c45bd4f85739ca4e0c33afc94494e28ab8a"
  head "https://github.com/xdebug/xdebug.git"
  version "3.0.1"
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
