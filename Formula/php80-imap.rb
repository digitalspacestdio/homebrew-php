require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Imap < AbstractPhp80Extension
  init
  desc "IMAP Extension"
  homepage "https://github.com/php/php-src/tree/master/ext/imap"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  def extension
    "imap"
  end

  def install
    Dir.chdir "ext/imap"

    safe_phpize
    phpconfig, \
    "--with-imap=shared, #{Formula["php-imap-uw"].opt_prefix}", \
    "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
    "--with-kerberos"
    system "make"
    prefix.install "modules/imap.so"
    write_config_file if build.with? "config-file"
  end
end
