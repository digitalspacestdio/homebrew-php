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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0beta5-100"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "33cd9b1cb5b2f42eafe4e821bd545e0fa92e40756afefabc5964e18d9d382774"
    sha256 cellar: :any_skip_relocation, ventura:        "269f1af7d1e9645fed03bb146ccf1c4c243b53ce2c139a3a0679f7c6208a5660"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "20b60124c02258e4fb68d3d3df31d9fda585a4cc19053accc4e54082a3052e53"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "f33107dfa60b714802f1ab0483b9790b42efa918af67fd424a72bdf74e06dc43"
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
