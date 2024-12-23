require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Tidy < AbstractPhp84Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.1-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e9a0f8816b7da003c2c7cac070d284d2d71978f74def294ef4319b5b72337bd4"
    sha256 cellar: :any_skip_relocation, ventura:       "4ed83aa5f1db140f561e98d18228cfa7954b450481787b76ef9dae5895bbcd16"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b22e4edd4ec991dec327ee1d70292c0cba0642764e4c9ab815d87d86154206ed"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "375f88e60c894b921a69182063e31f30d0b8d49243b09ca8164561f947cdded4"
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
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
