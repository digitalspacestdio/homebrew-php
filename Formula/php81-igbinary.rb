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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "65dd06c5170345df1c1cc5590ed13c9602b03258f4157f6dcfb348df1d5fba5f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d154528b3213757b50d70eb82b79073b7954c0e2dd82a6823d5c07dc28eccf7b"
    sha256 cellar: :any_skip_relocation, sonoma:        "ed677516831c2816b6482c0e6fa1f448d2bdaeb1eb30fcb15f9fe4ea090bd2f6"
    sha256 cellar: :any_skip_relocation, monterey:      "ebf7f6d6ec7db2a5c71191f71ea90e8a11ce95aabd2b62de8efb4caf28c0b5fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4501b95669ba7aa46ac752c70ee7d18368ad2ffdc3a217672bb4f3f6ce3725a3"
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
