require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Igbinary < AbstractPhp84Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.15.tar.gz"
  sha256 "6fcbd7813eea1dfe00ec72a672cedb1d1cce06b2f23ab3cb148fa5e3edfa3994"
  head "https://github.com/igbinary/igbinary.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.4-110"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "298e70ac136861f5d7a295166a569c7f871822c4b078d0652f3970cfe3337ed2"
  end


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
