require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Ds < AbstractPhp83Extension
  init
  desc "Data Structures for PHP"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://github.com/php-ds/ext-ds/archive/v1.2.9.tar.gz"
  sha256 "ee7d407b5d3e0753d287ed76855b0854287ad367e0953885b5f0f0d4ed335aa9"
  head "https://github.com/php-ds/ext-ds.git"
  revision PHP_REVISION

  def install
    safe_phpize

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"

    prefix.install "modules/ds.so"
    write_config_file if build.with? "config-file"
  end
end
