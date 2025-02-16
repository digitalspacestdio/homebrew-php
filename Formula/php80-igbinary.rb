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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-105"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "82a3cc2720a891cea27783fc1c14c44738c4c8e287c0bff52599501415b352cd"
    sha256 cellar: :any_skip_relocation, ventura:       "bbc28c44866d57760940da9f8f83784cd9ae3d90c5e489876993de7b5d6efbed"
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
