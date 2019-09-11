require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Xdebug < AbstractPhp74Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://xdebug.org/files/xdebug-2.8.0beta2.tgz"
  sha256 "4cdc590909074b1e28525f354d14283e663bf20e17c468246a09633553a1fea5"
  version "2.8.0beta2"
  head "https://github.com/xdebug/xdebug.git"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "xdebug-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-xdebug"
    system "make clean"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end
end
