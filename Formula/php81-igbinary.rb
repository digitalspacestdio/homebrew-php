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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-110"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "46f4747e3ceb459441db928e062f186879359f111c38ee96d80f14bcbc4b1eff"
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
