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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "671807533e59b12f347cbc06546b3c5cc04df543bd40b16fa69560f1e9339bd5"
    sha256 cellar: :any_skip_relocation, ventura:       "19dbee590f864540d311153a4ac2b3a1cd4caf6065ebed43c7ce63b521acda89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9d25c451f90230aa504faa0e018a8f8dc8f98b14347e8708ab8b35ad3caf2fd0"
  end


  depends_on "pkg-config" => :build
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
