require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Igbinary < AbstractPhp72Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.5.tar.gz"
  sha256 "1d06fc3586d61fcffbae24a46649db54d938168586557965bc1346f6d6568555"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b87a6bcdc127648df296d732dfcae7ad7b8654665b5987222218bebe76fc8063"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "12a67cc046dac5c1a2e8f7d62616d5fe9a4980e6470735611251de3149d361fd"
    sha256 cellar: :any_skip_relocation, sonoma:        "d2ef96c1d50c375e4f58a016fb940ad35767e87e95dd1d1585199c35bce30a8b"
    sha256 cellar: :any_skip_relocation, monterey:      "83f9e62db561aa4a6ff498b4779d3d6ef9ee51fc02141ab27784ca4045694519"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "505e517e4836f1460dc0a18f56ee8ab0ff6a32df9ff270be235e0d26296fff88"
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
