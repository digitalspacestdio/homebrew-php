require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Ds < AbstractPhp80Extension
  init
  desc "Data Structures for PHP"
  homepage "https://github.com/php-ds/extension"
  url "https://github.com/php-ds/extension/archive/v1.2.4.tar.gz"
  sha256 "c080bb08445fe690da2271ff866602cf27cadee529ab1a1edbf4aa7a1d6e104c"
  head "https://github.com/php-ds/extension.git"
  revision PHP_REVISION

  def install
    safe_phpize

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"

    prefix.install "modules/ds.so"
    write_config_file if build.with? "config-file"
  end
end
