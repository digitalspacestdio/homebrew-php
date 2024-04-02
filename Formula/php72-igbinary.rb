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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1ba52e860bc6f3a2821980c72efe7ea6f502cfd89f4ba0882c81d5923d8842ba"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "12a67cc046dac5c1a2e8f7d62616d5fe9a4980e6470735611251de3149d361fd"
    sha256 cellar: :any_skip_relocation, sonoma:        "b8767cf1648efe66735cd109251656e8d063b9555a1de4325b59565797131754"
    sha256 cellar: :any_skip_relocation, monterey:      "ea77e941564700756812d3fc7f2c50422a2896097268cbe438127a6ecef4f45d"
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
