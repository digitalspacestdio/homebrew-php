require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "201da371829729adea9658a59908a164579943e854702574aed2671412422dfa"
    sha256 cellar: :any_skip_relocation, monterey:      "2e71ed771e7e6945b631d4fc702f6250d545c03b75be9adb30629b38d2067416"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c8c1f749a9b597467f7a8b6422e298ac736131615d4566abcbbcbfb86a9a5506"
  end

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end
