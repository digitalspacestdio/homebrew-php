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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "062252eddc72d93ea86955f5e59bf0e33cf35e3e049d5db28e26aa46f8e70b33"
    sha256 cellar: :any_skip_relocation, monterey:      "25de9bf20c6a8d1da840221f967173a9372312adcf4429ed7b1477df28baba62"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1925cc913539d67c0087613ad4d7166c5a038192499e9d197737596cb4dad989"
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
