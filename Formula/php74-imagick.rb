require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Imagick < AbstractPhp74Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://github.com/Imagick/imagick"
  head "https://github.com/mkoppanen/imagick.git"
  url "https://github.com/Imagick/imagick/archive/refs/tags/3.7.0.tar.gz"
  sha256 "aa2e311efb7348350c7332876252720af6fb71210d13268de765bc41f51128f9"

  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-111"
    sha256 cellar: :any_skip_relocation, ventura:      "de06953ae89e9f36e9ee7fa82513f8fefd5f1deed558a8555edd51c73574d44c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "91146ee029326caf4dcf58ef9d173e440f0be7fa65a9ed00ecda0dd375c9fe51"
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
