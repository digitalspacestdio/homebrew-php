require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Igbinary < AbstractPhp73Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.0.1.tar.gz"
  sha256 "a340f3fa3bb250a6353f3b90fb25c0b68fb1afad342d1031c65b69fcd995909d"
  head "https://github.com/igbinary/igbinary.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c816c5a4d27655296e7426feec52b55659e5fb8ee0a9460e156f3a92e3625b8f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6882ab41311cc7c81bb35b23b6922594b03e423c0401b5c3430ef843545f1c34"
    sha256 cellar: :any_skip_relocation, monterey:       "f2ddc8dc4f4c1f8b4c5a554ac6e64d22e438a8763993361c33bc4a9fe244a7d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c560c4ca01bb364ecbe555aa1f9071eacd1deac565c5a546a57e5c6283003680"
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
