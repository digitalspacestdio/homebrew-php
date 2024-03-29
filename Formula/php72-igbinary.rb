require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Igbinary < AbstractPhp72Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.5.tar.gz"
  sha256 "1d06fc3586d61fcffbae24a46649db54d938168586557965bc1346f6d6568555"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1534e96d04f1e42c057478153ae5c013ea74acbc73ad50952bea8793862c68f6"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1cac83b817ba7d7aebaf3f4d120d2417736b044df2757fb3563bf7ce3a08cf7d"
    sha256 cellar: :any_skip_relocation, sonoma:        "87b66f0a20bc47006276514d99914c98e8e15b3c5be56cb91026777b694e53d2"
    sha256 cellar: :any_skip_relocation, ventura:       "7dd3ffb889984ee0d1296912d9cbf0095435abdca9f95b0bd7fae788aa3b4779"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "609bb79d9bbbf2cbf3d162ccedca8efc6aad37300c9a3945b82a27bfb7070608"
  end
  revision PHP_REVISION

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
