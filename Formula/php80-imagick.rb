require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Imagick < AbstractPhp80Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://github.com/Imagick/imagick"
  head "https://github.com/mkoppanen/imagick.git"
  url "https://github.com/imagick/imagick/tarball/132a11fd26675db9eb9f0e9a3e2887c161875206"
  sha256 "5cf964a7a5ba6e28d81507638f41a10d88070f0ee1b8019a650e2a4490609c2a"

  version "132a11f"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-110"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "56add380f1d321d6871c0f1549e5dc98aea39bd083f646f1274fda9b2d29d629"
  end


  depends_on "pkg-config" => :build
  depends_on "imagemagick6"
  depends_on "pcre2"
  depends_on "digitalspacestdio/common/imagemagick7"

  def install
    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"
    
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-imagick=#{Formula["digitalspacestdio/common/imagemagick7"].opt_prefix}"
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
