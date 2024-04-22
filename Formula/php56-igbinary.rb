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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7ce9a4130c29c210e2dcc80e5ed1c483a8b0e28e220ca5486701da0ae368ee8a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "38b2817ca465ee39d73ff8862e17f081534eccc5fb37462da37ee7f9f8221788"
    sha256 cellar: :any_skip_relocation, sonoma:         "4113dd206f65ab6f294a9d015d62220839994602cd79e02f58e8f652b744f0be"
    sha256 cellar: :any_skip_relocation, monterey:       "569f79e50f8105510f4b276bed0534586e9978e65f63190364a33a8f9eb0c81f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2f66a18df1cb5ec720186ec4d1da4fcaf086213a454d8c40410a6d1b7f1b697e"
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
