require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Imagick < AbstractPhp82Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://github.com/Imagick/imagick"
  head "https://github.com/mkoppanen/imagick.git"
  url "https://github.com/Imagick/imagick/archive/refs/tags/3.7.0.tar.gz"
  sha256 "aa2e311efb7348350c7332876252720af6fb71210d13268de765bc41f51128f9"

  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.27-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3f703efa075ed3ea112ba26b06acf8bb3b98b06ea869433663f2be53232d19e8"
    sha256 cellar: :any_skip_relocation, ventura:       "f29ef9cd82bb5c40f50b1545bb0c4b0cc9a1f10d17e3bdeb636503686e6dc685"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0dacec9532b0113fdabdf04fa3bee009910cfecf52a889ecb9c08f402a3dbd52"
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
