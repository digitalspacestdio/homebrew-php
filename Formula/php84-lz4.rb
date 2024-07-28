require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Lz4 < AbstractPhp84Extension
  init
  desc "Handles LZ4 de/compression"
  homepage "https://github.com/kjdev/php-ext-lz4"
  url "https://github.com/kjdev/php-ext-lz4/archive/0.4.3.tar.gz"
  sha256 "65f9b633a07d4cb356d4ed005878aec7788a1c62cb8e2a9038b18b486bb4fdb8"
  head "https://github.com/kjdev/php-ext-lz4.git"
  revision PHP_REVISION


  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/lz4.so"
    write_config_file if build.with? "config-file"
  end
end
