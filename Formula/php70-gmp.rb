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
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "bf77f8080a9cc0684b07997fef2ff3d9bc4a6e17b49e462631f20d76578dc7dc"
    sha256 cellar: :any_skip_relocation, sonoma:       "f3881c1db1bed8e705e63725d714c49cadffc13601421ea0cf44b4c4ff8962b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f32302af2c464dd2a0586cc2e9e605879633c416f27d1b1420f33362246a5d9a"
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
