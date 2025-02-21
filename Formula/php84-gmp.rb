require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Gmp < AbstractPhp84Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.4-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4eb655be24bbcbd6d1bf5d460df21d228fcae7c0693ceba6255fa6bc2e403b83"
    sha256 cellar: :any_skip_relocation, ventura:       "089983f35a4ea78f6104eba3470a62bfafa06ab009f23ce4c8344e5d4154cb3c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ea963b4fb653518c57553f39d21389bef0287893afe23f02d7738afc9df797d1"
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
