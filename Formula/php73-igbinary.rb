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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c224d3c2ab1dcc7c193ee2d2ccf7c4b8c6bcf5d3f684c570c603c1a687e7b135"
    sha256 cellar: :any_skip_relocation, monterey:       "29e9a7bf8d238a77ba6f63936faec2f324ec4596535469fe14f7b7a8797705d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5b02590f4808b13883e96709117364f6660d1d21e4b1969b34dbc064f589b819"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "356c593c1b0b30a6f1fe1a382e1a1c1cefd77c06eb6d3538b8ab0c1b1ef209bd"
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
