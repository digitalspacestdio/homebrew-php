require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Igbinary < AbstractPhp74Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.0.1.tar.gz"
  sha256 "a340f3fa3bb250a6353f3b90fb25c0b68fb1afad342d1031c65b69fcd995909d"
  head "https://github.com/igbinary/igbinary.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a4697544c1d3ecd54a55be46ef274383df0ac1d82523091aea5314a1b71a24b1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "23120f5bd60bcb5d667aa0005c426e0adb34256d322eafb37971be3b193f275e"
    sha256 cellar: :any_skip_relocation, monterey:      "4635bfa0075d5f342a03a3d214d12741c6235ad574ab9c9b8e626f1ac92aedcf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cc41f76583be38d8f93474a77c2c57ebc69281257b9847050945128a922d0de7"
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
