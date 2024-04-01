require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Igbinary < AbstractPhp56Extension
  init
  desc "Drop in replacement for the standard php serializer"
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.5.tar.gz"
  sha256 "1d06fc3586d61fcffbae24a46649db54d938168586557965bc1346f6d6568555"
  head "https://github.com/igbinary/igbinary.git"
  revision PHP_REVISION
  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "726b0fe80f09882d57882ada8fee96e178014f588e60eb71cf08a86afd0eb9b7"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2b8f41532b7baa417055e037cd694a67cf784bf519bb8c530bea55b06c9f5900"
    sha256 cellar: :any_skip_relocation, sonoma:        "ef5278285180c566e634a8655b74dbdfe2b47906b9c2da5699349293d7ada7c7"
    sha256 cellar: :any_skip_relocation, monterey:      "f7d657cf995034b9781a942bfcd9562e3ae393083af0cc9aa072fe7407b2403b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9dff8ffcc4fac3447fcfdd66a0830e1741dd333d3dd434bfde29a4eb5e66d653"
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
