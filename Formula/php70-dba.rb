require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Dba < AbstractPhp70Extension
  init
  desc "Database (dbm-style) Abstraction Layer"
  homepage "https://www.php.net/manual/en/book.dba.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "berkeley-db"
  depends_on "gdbm"

  def extension_type
    "extension"
  end

  def install
    Dir.chdir "ext/dba"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-ndbm-dir=#{Formula["berkeley-db"].opt_prefix}",
                          "--with-gdbm=#{Formula["gdbm"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/dba.so"
    write_config_file if build.with? "config-file"
  end
end
