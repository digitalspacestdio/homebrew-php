require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "net-snmp"

  def install
    Dir.chdir "ext/snmp"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-snmp=#{Formula["net-snmp"].opt_prefix}"
    system "make"
    prefix.install "modules/snmp.so"
    write_config_file if build.with? "config-file"
  end
end
