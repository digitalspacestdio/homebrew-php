require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Yrmcds < AbstractPhp56Extension
  init
  desc "Memcached/yrmcds client extension for PHP5"
  homepage "https://github.com/cybozu/php-yrmcds"
  url "https://github.com/cybozu/php-yrmcds/archive/v1.0.4.tar.gz"
  sha256 "b509631c57d60d9003954164756448454f8a09e789dc67ce531363c6c08bc273"
  head "https://github.com/cybozu/php-yrmcds.git"



  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/yrmcds.so"
    write_config_file if build.with? "config-file"
  end
end
