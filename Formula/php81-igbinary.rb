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
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ebf133162a6b5ca8ce26009c1c9419292cad7d4c4e49e6fd547cc1b50ab2ea87"
    sha256 cellar: :any_skip_relocation, monterey:       "15939b3d811f02cb9a5d4c07f636550491953cfe577f9c6ae4dd3f8fe02a024c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9923c242bac59074fad75a825ba25b2addc50306b63e706bbcadb9002215e3ff"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "8d33263fdaf990c906390305154a9d565828055ff232e3cae54d5aae77612d93"
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
