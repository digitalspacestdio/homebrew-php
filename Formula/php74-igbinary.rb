require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Igbinary < AbstractPhp74Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.0.1.tar.gz"
  sha256 "a340f3fa3bb250a6353f3b90fb25c0b68fb1afad342d1031c65b69fcd995909d"
  head "https://github.com/igbinary/igbinary.git"
  revision 2

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8b069c2cb045832583db216e780f6e4ba1c59686fdbd5cb80e393f938503f522"
    sha256 cellar: :any_skip_relocation, sonoma:        "3b938ff9760f69e1807c98f60353964e1dbb42adbc42ae3ca545e70ce5b31814"
    sha256 cellar: :any_skip_relocation, ventura:       "4bc984f3519416757f6c5e12420a126961ec34fc5530b0133a503c0ace4f3130"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a8337cbc2e6583e727cb1c1bdbb39d415cc522668470f2d11db5eda6748329bb"
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
