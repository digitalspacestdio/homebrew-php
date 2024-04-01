require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Igbinary < AbstractPhp73Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.0.1.tar.gz"
  sha256 "a340f3fa3bb250a6353f3b90fb25c0b68fb1afad342d1031c65b69fcd995909d"
  head "https://github.com/igbinary/igbinary.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "38fd8d23a0a67da28286f0e7437aba305e852193efc747c45f13f9dd74736cf6"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c4fba5f1185e04a176813e7803e0184b096e580f8cf915ecd99742dc387a1cfb"
    sha256 cellar: :any_skip_relocation, sonoma:        "f94efb16828b0f668f369e089fdc81738f635ce9d18b01bacef9d767ee4db931"
    sha256 cellar: :any_skip_relocation, monterey:      "019f88c12d1dd0ec22a5a57ba648dc5be964683bbb305339d0858eb717db5bff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8ea63c69b3b35130521141e3dae8eab466c40f2747e8b86a1a6c3d50f353b573"
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
