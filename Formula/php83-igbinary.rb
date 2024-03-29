require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Igbinary < AbstractPhp83Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git"
  version "3.2.14"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "26f2b94a5ac8dd3f02a205fc6f44832462b409ad1bb28ea1ae56ad062aaa7f0a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "75631816a448d3484a132153e7119cd4799706f24d802d201a0bed6c7a2bec9f"
    sha256 cellar: :any_skip_relocation, sonoma:        "9280ae8358e4f6e1390584f206714a21c831d31f268484607cb90ac7adfc2e69"
    sha256 cellar: :any_skip_relocation, ventura:       "12a559cfbf887085ca3852d451b57f27731360ff29ecea68b416c910b931e911"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4ad39ecfce4da933e62dad1b2be836bf5c6d7166fd81a19a265af87e0bb181b"
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
