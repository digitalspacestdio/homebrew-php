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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d25ba069f537de67146c85c21915778f2fc151b1cd3aa01e001ef8d6aa5cd0aa"
    sha256 cellar: :any_skip_relocation, monterey:       "346ca05d3c3dae62fbe105a32def92f18dbc385feb6a869ae726f90de0d54783"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "833694177d385025e5987d8eab33c340d457b03bcfd536112fa6fd0b9be51124"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "a5af50910976ea3a0a42ba2477adade834391c7dedd4d9858a0036291d7d6c8e"
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
