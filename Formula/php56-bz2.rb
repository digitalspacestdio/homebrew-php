require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Bz2 < AbstractPhp56Extension
  init
  desc "The bzip2 functions are used to transparently read and write bzip2 (.bz2) compressed files."
  homepage "https://www.php.net/manual/en/book.bzip2.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "bzip2"

  def extension_type
    "extension"
  end

  def install
    Dir.chdir "ext/bz2"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-bz2=#{Formula["bzip2"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/bz2.so"
    write_config_file if build.with? "config-file"
  end
end
