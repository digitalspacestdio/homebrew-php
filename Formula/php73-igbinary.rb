require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Igbinary < AbstractPhp73Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.0.1.tar.gz"
  sha256 "a340f3fa3bb250a6353f3b90fb25c0b68fb1afad342d1031c65b69fcd995909d"
  head "https://github.com/igbinary/igbinary.git"
  revision 2

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "097f807f01216a206c5e1de090693097b122d21ea67340142779082c23eeedf5"
    sha256 cellar: :any_skip_relocation, sonoma:        "227cb11510c3492a0d4a5c9a697e2d482258f601f434b64c55c8324a406031ae"
    sha256 cellar: :any_skip_relocation, ventura:       "ed205d00cc08c4b2009f7fcc25ed24bbfd624f3f4110a1589e4ba5cb71ac83b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "538bf084ba469b4ab187d51df822ea9a0af9b83c9b4e03bc3667808a80ae7cec"
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
