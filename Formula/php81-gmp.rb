require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Gmp < AbstractPhp81Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "fe9d8a56b8c8be1fdd14c80393e7a7bebe35ec939c729aa9d7864a1df0c5c2d5"
    sha256 cellar: :any_skip_relocation, monterey:      "710f5d206359d6f7185eba987f891318b2fb13223d5d3c5817c681f4126832ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bbd942e6d21331405245cda4d019030e13cc1c1521a91a5d055747bd98b2da36"
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
