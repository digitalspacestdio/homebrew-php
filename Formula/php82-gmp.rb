require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Gmp < AbstractPhp82Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b69980bc781abfcff0cee37d20017965bba467496c7b645231504d90dec80054"
    sha256 cellar: :any_skip_relocation, monterey:      "00eb6786500cd7453ed606fea7fc95cb3f2b87a303581ca007c91b168851c6cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fe9d8beb23959b184df559969c56676cadaa664b57a9ea83a83a1c104b32d5d9"
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
