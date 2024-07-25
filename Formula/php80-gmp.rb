require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Gmp < AbstractPhp80Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6f6b2e057cc3188ab8f9d6622dd911d6094ac5df9c417880a78db91d1a60ff5e"
    sha256 cellar: :any_skip_relocation, monterey:       "f344187a7b7791e70efc7af52c9d57381d08cee1606b4b37ece1040b5be5ad95"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6219cb3791d2295f20164f1de6d415106e8de03eb5a771930e67225fc15129c7"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "b6b24dde2b93b43f4d34b56a5807b38caa9695583303ad09cdd2cca5f126af30"
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
