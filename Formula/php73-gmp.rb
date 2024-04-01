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
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "4adfb96b7d366ddd14d6395518a684370bb2b39cc4fd5689368d1739961a60cc"
    sha256 cellar: :any_skip_relocation, sonoma:       "115a552dbc2573e695d7ff71c050ce59698e3c561bb6a4a2a225f6ceb9a34a8d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c8c459ce484878fd3d5fdf417867484ad462cf17b4bdd7b77e5ca7d45b5ddaec"
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
