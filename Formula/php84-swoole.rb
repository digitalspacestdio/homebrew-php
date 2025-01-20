require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Swoole < AbstractPhp84Extension
  init
  desc "Event-driven asynchronous & concurrent networking engine for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://github.com/swoole/swoole-src/archive/v6.0.0.tar.gz"
  sha256 "fade992998cd89e088c46c80c0a853ef620d4a883de698a913b2dfe7f842d5bb"
  head "https://github.com/swoole/swoole-src.git"
  revision PHP_REVISION

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--enable-coroutine", phpconfig
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file if build.with? "config-file"
  end
end
