require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Gmp < AbstractPhp84Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0beta5-100"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5b572c4595d73e034bb4adb02f2ae7a01fae087ab2374926ad39a97dcbced18c"
    sha256 cellar: :any_skip_relocation, ventura:        "57d92791171ac88b2b474b2f11eef78ccb9118b33d9b3415eb6247f09f723452"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e5b0ff5cd33daae1e1fee342db8b453d9d05126ea020df9d45e9de15706ab0a3"
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
