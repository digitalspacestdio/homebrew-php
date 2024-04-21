require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Opcache < AbstractPhp83Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d82768964e13bf2d2232519bb20406bc9789175fbac9df9399c4845b9290c128"
    sha256 cellar: :any_skip_relocation, ventura:       "1e149bbaa44a1f3e95210d921ac910180e4ffa6eb284d07f3322a168052ec73f"
    sha256 cellar: :any_skip_relocation, monterey:      "3c12f9d779fbb9d0c9ed77f337d8c3174171fd2ef95beb34f2b1d9baffde54a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fca7b917fccce8d8202929f4ddc20367ce08b85e214059789e4a1ded58c340a3"
  end

  depends_on "pcre2"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
