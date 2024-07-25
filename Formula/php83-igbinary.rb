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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.9-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8dac170d0ec9d1b3cbe08cf62f443aedab63ec75062e6ae143be429a3764d94a"
    sha256 cellar: :any_skip_relocation, monterey:       "8ea09fa9dd1147876a6b0ab92f049e9bd6ce17317220fd5488b800b379f71c2b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7e95027c1ee72d73431a347ee0cb8f36f5ef1d52329dc6b3fe71167614af2be9"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "4336d2dd053f3063d72d53c55d07037d525257fabdc91bf8f4d5c498e6701f2c"
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
