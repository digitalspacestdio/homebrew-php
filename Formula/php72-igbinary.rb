require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Igbinary < AbstractPhp72Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.5.tar.gz"
  sha256 "1d06fc3586d61fcffbae24a46649db54d938168586557965bc1346f6d6568555"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-104"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "52f095eed0a3c8afca8ff0fcef8ec71f0b7fb30138d0ad71df8607d149dfa0fe"
    sha256 cellar: :any_skip_relocation, ventura:       "4075eed9c0c6ced0571f0579493dfb9122ea6d4b4ac1b4a90f4de44833939ac0"
  end
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
