require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Igbinary < AbstractPhp82Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git"
  version "3.2.14"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0b623bccc710cf7fb7f1aa6f8b101530d06ad1056f9216cda9561243825cf866"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1015a00bb83b38cc8129675c7faa6d95ee87db685d98f5d83f7a8f2a223a08c0"
    sha256 cellar: :any_skip_relocation, sonoma:        "b46dd5315cc0bf0cbe65e8723b6c8bd2a5c0f099a58c9b1c4ffd344be9519d5a"
    sha256 cellar: :any_skip_relocation, ventura:       "bb300b4f5cff5dc7f9cf6a85cf31b192a5c0293fc89799ce408b6b0a3cbfe7c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8e7cbb534f7668223268a9bd4d1d8eb0acae996cecf83133fd3d1399465023a0"
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
