require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Propro < AbstractPhp56Extension
  init
  desc "Reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://github.com/m6w6/ext-propro/archive/release-1.0.2.tar.gz"
  sha256 "35b1d0881927049b3c7a14dc28306e2788f9b2bc937b1ef18e533a3bef8befce"
  revision PHP_REVISION


  def install
    # ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    include.install %w[php_propro.h src/php_propro_api.h]
    prefix.install "modules/propro.so"
    write_config_file if build.with? "config-file"
  end
end
