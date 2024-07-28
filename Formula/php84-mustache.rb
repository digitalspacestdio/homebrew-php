require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Mustache < AbstractPhp84Extension
  init
  desc "Mustache PHP Extension"
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  url "https://github.com/jbboehr/php-mustache/archive/v0.9.3.tar.gz"
  sha256 "310f7b29c359fd7af00704bfdbaa9d22b11ff947a12231d2e16a1a7e886d88a5"
  head "https://github.com/jbboehr/php-mustache.git"
  revision PHP_REVISION

  depends_on "libmustache"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/mustache.so"
    write_config_file if build.with? "config-file"
  end
end
