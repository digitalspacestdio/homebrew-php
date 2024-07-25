require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Tidy < AbstractPhp82Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "918d1550c41a59763eec3fb9f0727d47fe340e8dda4e4254c8718641d25d9248"
    sha256 cellar: :any_skip_relocation, monterey:       "8e2375bc9c12fade667f868c9fc5cd571345241373eea2c3d25dbe962d05ae14"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0f2c356a469c5117f62494f76ba31346f6ea79a23ff77e469882b5009e9c8667"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "def1e8e5e5ea82aa04dc4256cf6d2e3d4b5eb1e1f9767ebeef5ddd4a87498051"
  end

  depends_on "tidy-html5"
  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
