require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Gmp < AbstractPhp73Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4adfb96b7d366ddd14d6395518a684370bb2b39cc4fd5689368d1739961a60cc"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a9d6e7931a9266271c77ddef37d0a45929c430c50aeb6527f9379f831fe888a5"
    sha256 cellar: :any_skip_relocation, sonoma:        "998717735673fcb4b70161f20cde077d43437394243308cff231d0e1034b39ab"
    sha256 cellar: :any_skip_relocation, monterey:      "58063d2ec1bf2a19dbbead02314a01a11f3dca227461ac77a62b65ad43045ff1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c8c459ce484878fd3d5fdf417867484ad462cf17b4bdd7b77e5ca7d45b5ddaec"
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
