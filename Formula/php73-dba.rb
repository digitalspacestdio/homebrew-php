require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Dba < AbstractPhp73Extension
  init
  desc "Database (dbm-style) Abstraction Layer"
  homepage "https://www.php.net/manual/en/book.dba.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "berkeley-db"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-ndbm-dir=#{Formula["berkeley-db"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/dba.so"
    write_config_file if build.with? "config-file"
  end
end
