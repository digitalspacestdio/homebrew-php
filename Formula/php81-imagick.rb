require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Imagick < AbstractPhp81Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://github.com/Imagick/imagick"
  head "https://github.com/mkoppanen/imagick.git"
  url "https://github.com/imagick/imagick/tarball/132a11fd26675db9eb9f0e9a3e2887c161875206"
  sha256 "5cf964a7a5ba6e28d81507638f41a10d88070f0ee1b8019a650e2a4490609c2a"

  version "132a11f"
  revision PHP_REVISION


  depends_on "pkg-config" => :build
  depends_on "imagemagick6"

  def install
    #Dir.chdir "imagick-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-imagick=#{Formula["imagemagick6"].opt_prefix}"
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
