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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0760282b8d6c66855ff435ca733a773624bdfe542409a75ec9fc04329881a4a1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4fd018ca9bbc1a99d33dd85b16ae1a5e87e8cb70356e0ea9cd42cc3e2c10aeaa"
    sha256 cellar: :any_skip_relocation, sonoma:        "7f30989bfc8a86246caa650e8f8a6e1929e893132f24cc082a3cd47e9340765f"
    sha256 cellar: :any_skip_relocation, monterey:      "938218613c4f3990d23702855f3895cecb2ca8a6ed069d0ad2ad7d9319eaa38a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0be46a059cc5abb97343f37212b0f507a47b5f53be404cfd791d547f6d673985"
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
