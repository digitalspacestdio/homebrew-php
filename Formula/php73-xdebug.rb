require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Xdebug < AbstractPhp73Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://codeload.github.com/xdebug/xdebug/tar.gz/02890b34d419e6d0364946ddd904a0ebfbe92bca"
  sha256 "227e39d602afc993af5fa761c746eb1d59b0622625294f28a1adcc0f527650b9"
  head "https://github.com/xdebug/xdebug.git"
  version "2.9.1"
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
