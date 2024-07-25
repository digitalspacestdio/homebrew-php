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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2ebc54009c6ae675801d09bb20a3144762efa6894d665b05edbb2523854ede09"
    sha256 cellar: :any_skip_relocation, monterey:       "b6cfe3fcb040f2cf2e7f85e30e934d19500d8a6f00b915b8c536f2f865b0ce43"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fcaacfe036314e5c096e6d78dbf1cc2142ed67256fc696ab1d7e9b94fbf9bd06"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "0ed8c42a5cdd4825170a899fbd427e92e830f5270ce96928bc422c0d919d1c8c"
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
