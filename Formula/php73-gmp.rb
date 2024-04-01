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
    sha256 cellar: :any_skip_relocation, sonoma:       "77cdc2267e4c3362adf0c1bee36a97268164d81f7ba5705316bb6940e8e9dca0"
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
