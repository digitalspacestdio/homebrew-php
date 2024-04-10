require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Gmp < AbstractPhp83Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "83d0901000bc04f87bea9dc611d0939181a463337e5d6cb1e88bc2c2a6017e73"
    sha256 cellar: :any_skip_relocation, monterey:      "a5c161f1f97ae3818a06fefcf56f785b09546a490923b52dfda942805e1c3dda"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e9a8b313644ff6ee70eb551ddaca9f09cabb146575803a91fe6ecab56b2acc66"
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
