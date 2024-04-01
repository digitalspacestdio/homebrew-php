require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Igbinary < AbstractPhp83Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.15.tar.gz"
  sha256 "6fcbd7813eea1dfe00ec72a672cedb1d1cce06b2f23ab3cb148fa5e3edfa3994"
  head "https://github.com/igbinary/igbinary.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9dab45fb1fb1e3f8745c9c1a6b565928e6b118301cfd8c6dfc2c9ff9da9e15e8"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0452bd13c2ed655181978df6deddf7ca87fecccd827ca31cd9d84ccd536dfff8"
    sha256 cellar: :any_skip_relocation, sonoma:        "42e5f4f3cf8f3d1b491ece3ce9db1e24f91420147f83a2986dcc7d22739fd14c"
    sha256 cellar: :any_skip_relocation, monterey:      "865ae9809ec99bee5c89f054ff7ff63f0de7f37b9bc9b104c3169c6a6d18eefb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "22687f3a879016ac8a6cd22fa1a7f7373094d6aaae765679dde8ce3535a6298c"
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
