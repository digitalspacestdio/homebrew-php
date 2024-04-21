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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ffafae00a44eb517df1b363e3b90fe4e1ab25551eebb7a6209304638be1df788"
    sha256 cellar: :any_skip_relocation, ventura:       "31d81fdfd06807d30d23f04427d935abc69c7239baf79cdc378991830dfccfef"
    sha256 cellar: :any_skip_relocation, monterey:      "239e12e685514756fea74bc1933506cbb1442f4333a1df67315eeccb08c88014"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "64aae8007e2c89e5b6a86007a5436378412af446528456456e26c598aa3b06e7"
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
