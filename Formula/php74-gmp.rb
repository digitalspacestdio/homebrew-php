require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Gmp < AbstractPhp74Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "24807bab8bc21176729533dbb835144fc2e13c1032ae3d8260e9e49d80911d44"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "23331d17e287b96aecbb7313aa585204d7fa2da4daacd332415d52db5b3d9e49"
    sha256 cellar: :any_skip_relocation, monterey:      "f09e8bcad44f66ede8fbc420f01bd047a00bdd22213cd7edc3b3a54c5bbf9929"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "779f9dc73dd1036d5fe738c1918693032787f8c3163c0fd52ee66afba4d9ae71"
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
