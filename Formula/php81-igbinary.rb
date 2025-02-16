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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e07971d37e93f3efa89f9b05cc6a9b4f490251d2f4db6e4b89075ffc43e17c78"
    sha256 cellar: :any_skip_relocation, ventura:       "ee778c9fdb8d74ae82d39ab4a61a2552015e0238062a04328c2f72ae5fe9d88d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "feaad83a33246a8fc588248dd5d6820752261c2373dc726dd249f0609de65819"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "7c73db285352083d340598990eb6bd27566f3d1676a55531b637b6e0e19e4373"
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
