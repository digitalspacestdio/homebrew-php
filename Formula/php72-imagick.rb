require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Imagick < AbstractPhp72Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "33211e4ab16c7615549f6edc32a6276b6d7e2d5cb541f79fe23382b3a915be12"
    sha256 cellar: :any_skip_relocation, ventura:       "c06bfac76984ee862c85da6f4d3d3a2c30bc3fedbf96deb8fcfe35f05c3ee423"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "afab31098a2ee2dec3356ccf8df67a11b0da8db77893b9da14d06f03c9b499b3"
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
