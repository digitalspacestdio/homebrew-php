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
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.3.8-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e4719a042e133ebcc9fbd18490dd6ffa299951aadd003a8485d0030de594695d"
    sha256 cellar: :any_skip_relocation, monterey:       "987094c114b60e04c8bf2640a483f2637b97808436e684f6f04f7e6e96609e74"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2b87589f1d2a2e263286be4663f8b8768f17f33086572802d689432a9f7ece1c"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "5c5073555887d3ec268d8ede035e2769c7bba238b446918b739955ba9cf0419e"
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
