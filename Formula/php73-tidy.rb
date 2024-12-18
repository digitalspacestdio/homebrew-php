require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Tidy < AbstractPhp73Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fc091197a54f30e2d18256c91b34bdc427cc6dbb026b654474d08fc37d3d2380"
    sha256 cellar: :any_skip_relocation, monterey:       "a5fbfcc06324afb8ea65e2298ab6dfc59297acab72d8898c87667d310f916fba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "71ea9601096ae06e9ebc71be920841231e1d52dd15ee1e5416c35a7c757fc01d"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "34fb5ff8392e4ca28a33a2c8fb1f03352a81c0019a11c97d6fc55b20bb0e3965"
  end

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
