require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Uopz < AbstractPhp83Extension
  init
  desc "Exposes Zend Engine functionality."
  homepage "http://php.net/manual/en/book.uopz.php"
  url "https://github.com/krakjoe/uopz/archive/v5.1.0.tar.gz"
  sha256 "ca3637ff1b8371c952c87ab17465e6957792d716583aadf9c2916e524b77f745"
  head "https://github.com/krakjoe/uopz.git"
  revision PHP_REVISION

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/uopz.so"
    write_config_file if build.with? "config-file"
  end

  def caveats
    caveats = super

    caveats << "  *\n"
    caveats << "  * Important note:\n"
    caveats << "  * Make sure #{config_scandir_path}/#{config_filename} is loaded\n"
    caveats << "  * after #{config_scandir_path}/ext-opcache.ini. Like renaming\n"
    caveats << "  * ext-opcache.ini to opcache.ini.\n"
  end
end
