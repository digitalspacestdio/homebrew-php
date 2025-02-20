require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Imagick < AbstractPhp81Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://github.com/Imagick/imagick"
  head "https://github.com/mkoppanen/imagick.git"
  url "https://github.com/Imagick/imagick/archive/refs/tags/3.7.0.tar.gz"
  sha256 "aa2e311efb7348350c7332876252720af6fb71210d13268de765bc41f51128f9"

  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-111"
    sha256 cellar: :any_skip_relocation, ventura:      "0cd710935986b231a0a682e7932d7322e1b880d34bf6a237478fa82ec7dfe343"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "44c4da9dee4aaabc9f1fb82af648c225534d0363fe97401b6f34820ecea65a71"
  end

  depends_on "pkg-config" => :build
  depends_on "digitalspacestdio/common/imagemagick7"

  def install
    #Dir.chdir "imagick-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-imagick=#{Formula["digitalspacestdio/common/imagemagick7"].opt_prefix}"
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
