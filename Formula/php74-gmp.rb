require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Gmp < AbstractPhp74Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5c4861a071c0675cdc595294ddc09c311c3fef4f1a6c844e8196be7fbe15d689"
    sha256 cellar: :any_skip_relocation, monterey:       "f353eebfea4b8172ae52a268804b7cc1e428db55dd139bb22ca3b8626e8b9fe1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "15333723c04995ba7d9d5e0932e83365e2cb7fdd79edd9ff2426a12ee3ab55a7"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "3287842fed4c4423025cd4817d23932c15e16b2a2eeb3d9bddfc132ba2fbab96"
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
