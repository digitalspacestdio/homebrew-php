require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Tidy < AbstractPhp73Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fc091197a54f30e2d18256c91b34bdc427cc6dbb026b654474d08fc37d3d2380"
    sha256 cellar: :any_skip_relocation, monterey:       "a5fbfcc06324afb8ea65e2298ab6dfc59297acab72d8898c87667d310f916fba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "71ea9601096ae06e9ebc71be920841231e1d52dd15ee1e5416c35a7c757fc01d"
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
