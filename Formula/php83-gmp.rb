require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Gmp < AbstractPhp83Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.14-106"
    sha256 cellar: :any_skip_relocation, ventura:       "539759024bf95b21bab8fb30b4af701e03c0b7f1eb704b012dd6b18461254196"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e4a5a41d5478bdd7af818414711b62bf34a7ccecc5a31f18e6d6307654bd90b3"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "4a297b6882b93b3765ea89dcd3458cb20fa1afc856e876d7e28bc12cf424d84e"
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
