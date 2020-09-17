require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Xdebug < AbstractPhp80Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://github.com/xdebug/xdebug/archive/2.9.7.tar.gz"
  sha256 "676d7a39751cf5020b7f15afd132d21602a693a178768ee2921c95bfb4c0cc6b"
  head "https://github.com/xdebug/xdebug.git"
  version "2.9.7"
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
