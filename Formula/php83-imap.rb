require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Imap < AbstractPhp83Extension
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
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/imap.so"
    write_config_file if build.with? "config-file"
  end
end
