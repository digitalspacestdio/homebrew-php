require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Igbinary < AbstractPhp81Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.6.tar.gz"
  sha256 "87cf65d8a003a3f972c0da08f9aec65b2bf3cb0dc8ac8b8cbd9524d581661250"
  head "https://github.com/igbinary/igbinary.git"
  version "3.2.6"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "80122561969ea077494d4eecbba8f4064e8820005ea309461a3957ed90ee67da"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4b9652ac4724132bc7127145baf072e0b2e4852f70acf70bba9d6b2b1d165247"
    sha256 cellar: :any_skip_relocation, sonoma:        "fab2217f3f86835b57beb2eb656e0287894d15dfd8a598f089ea7926f3affd28"
    sha256 cellar: :any_skip_relocation, monterey:      "ebf7f6d6ec7db2a5c71191f71ea90e8a11ce95aabd2b62de8efb4caf28c0b5fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "93dbd177b74778964b6fcd8490eca8476808b0f1709b2452229bba76a31bb5c8"
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
