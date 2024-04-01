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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ea9c16bf45814e57e5b4d485442b037a8848d2d7ba2cf77e25ec195e103a1236"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "fc592d7b3c170e932fdbacc51b45fc0b9d07f004476e07e9c1fb56bc545baf0e"
    sha256 cellar: :any_skip_relocation, sonoma:        "724043ebd358b8d8c68c01922c4c2b00f693e48e90b939eb6bb0250ac47a4224"
    sha256 cellar: :any_skip_relocation, monterey:      "ab8f946006aa3863aa75135af7b09ea814d9d73e2e0aaca2be48d88a8b523222"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "649a767be318e7aac4a2f8dceaf3725680233e59c81fb549526780183d2fb374"
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
