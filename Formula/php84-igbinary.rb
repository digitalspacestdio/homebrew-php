require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Igbinary < AbstractPhp84Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.15.tar.gz"
  sha256 "6fcbd7813eea1dfe00ec72a672cedb1d1cce06b2f23ab3cb148fa5e3edfa3994"
  head "https://github.com/igbinary/igbinary.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.1-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cbfd6d9b2826454596f6ed4b964e8319afab106c520e64902134dee005f5e62c"
    sha256 cellar: :any_skip_relocation, ventura:       "5d3d827173517e2ca95bb76028c6dbaab3af49d3f8748711ec4014bf08226308"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b47920f32266b1e2221183b77496f91eddcfb7e72f2469a946c85119618dbf27"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "4ccaaec78c39cfc9781767aa5ae13480bf691237264cdb2afedc094454286d11"
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
