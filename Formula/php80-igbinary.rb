require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Igbinary < AbstractPhp80Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.1.6.tar.gz"
  sha256 "86079a3a0e0ea46292ed0ebe69748c5e09c68fe5b0e274d0dd45f3d9c80f61a8"
  head "https://github.com/igbinary/igbinary.git"
  version "3.1.6"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1a0c9004d712faa63e53d14db78b9e3e1ca1c5851e72c9c03492393bba0eeedc"
    sha256 cellar: :any_skip_relocation, monterey:       "5c6587fa9f38c090eff2c753f970efa7552e1c0ea302218cf1a321a5e4b54164"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f344e9da96be44ebcc4804acebaf08e636bb15b4ffdacebd160856fe9090f0f8"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "70305f1126f3cb7950587b7b44e7392e72dbb239560729f1947c739d2a27918a"
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
