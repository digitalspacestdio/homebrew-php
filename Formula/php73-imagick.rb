require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Imagick < AbstractPhp73Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-111"
    sha256 cellar: :any_skip_relocation, ventura:      "8b7c2b6331b25f226b79aabc822d27a03a7c7b5558b5192f305100636f30f857"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ad91c48253e95436642961c6287d9902451c9682794a96c45b62e35d9d7a242d"
  end


  depends_on "pkg-config" => :build
  depends_on "imagemagick6"
  depends_on "pcre2"

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-imagick=#{Formula["imagemagick6"].opt_prefix}"
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
