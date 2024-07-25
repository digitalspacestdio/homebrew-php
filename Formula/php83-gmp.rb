require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Gmp < AbstractPhp83Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.9-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e911998530f90fa7c2c29a9489c2c456eb8d949d55e4cac17efcf87149799ca0"
    sha256 cellar: :any_skip_relocation, monterey:       "5e42efe0437da92eb724749f86e0f486e04a34c88be9ce36b1e829663d949802"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f06890b0193b8e55ba7bea341e50fce93888bb13ea9cf07fd86702daabb02c98"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "ea096fcc98b8799e4c0458ee6ba97a58387ef0c0a9b088a0ace8a432b42370df"
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
