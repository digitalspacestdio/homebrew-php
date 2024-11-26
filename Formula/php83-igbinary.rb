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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.14-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5db367a8aa0a62e5db469df53bb95fb06be7376cd87ac78cf8cc84bd7a4e9571"
    sha256 cellar: :any_skip_relocation, ventura:       "170adcca4791ebdfbfc210df72dba93736bc28b41328b25c10bee9eccfc43df2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "005a830ac68a5791e6661e1c0cbbc9c5006e923340e65352ecbf1bf087769d2a"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "77dd4bf1d29538a3df12d172557f8f78d2a252da35fc80b183eb81ba41195f12"
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
