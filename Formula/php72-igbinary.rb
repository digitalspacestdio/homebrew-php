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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "89037201b9e33871d1422480b184975f0b1100d9d6b4fce1b0780cccccedeb1f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9e21120b67f7c3ff7d9ae480b9152d345583dab9bed5a4132360f1229b3e2431"
    sha256 cellar: :any_skip_relocation, monterey:       "be7dfa834b23f836c81490e37070454b57d0bc11a0dfe361c16c15cc0322d890"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "46d4cf42427142d9fa539792f5756969692f12b5ca705922de3ee7b3d6052342"
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
