require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Xdebug < AbstractPhp74Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://codeload.github.com/xdebug/xdebug/tar.gz/b554fd406b365a0cec09e81200f16a2d30d59693"
  sha256 "3b37c0bc21e3d68237fc2d4faa002cc01d9de23c33da226ed5cf737562a8c6eb"
  head "https://github.com/xdebug/xdebug.git"
  version "2.9.6"
  revision 1

  def extension_type
    "zend_extension"
  end

  def install
    #Dir.chdir "xdebug-#{version}" unless build.head?
    ENV["CC"] = "#{Formula["gcc@10"].opt_prefix}/bin/gcc-10"
    ENV["CXX"] = "#{Formula["gcc@10"].opt_prefix}/bin/g++-10"

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
