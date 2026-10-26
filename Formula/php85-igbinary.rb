require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php85Igbinary < AbstractPhp85Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.17RC1.tar.gz"
  sha256 "d563482bd3f623a08bd38ecab1da69e2f8c0f87a781f8b395dd0a95c9959d6e4"
  head "https://github.com/igbinary/igbinary.git"
  revision PHP_REVISION


  depends_on "igbinary" => :build

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/igbinary.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
      ; Enable or disable compacting of duplicate strings
      ; The default is On.
      ;igbinary.compact_strings=On

      ; Use igbinary as session serializer
      ;session.serialize_handler=igbinary

      ; Use igbinary as APC serializer
      ;apc.serializer=igbinary
    EOS
  end
end
