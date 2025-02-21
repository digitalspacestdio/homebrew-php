require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Imagick < AbstractPhp70Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3a68c0c3b92bae43b42ce86f222e8121289396acc82db67570d90f051152da0c"
    sha256 cellar: :any_skip_relocation, ventura:       "5d6afdd43114b23a23dcda591ba69a4903faf02afbcff98803ad3478dde3b1ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "56d2d23b3cde943518310d2ec9b01a4b13b4ae8685d8d2bdde256b1f02a9a82d"
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
