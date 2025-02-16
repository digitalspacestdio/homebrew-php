require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Tidy < AbstractPhp84Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.3-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e20e83d47df7d6d465db9b4e472023c0b9b8181594e3377097435153cb2187cd"
    sha256 cellar: :any_skip_relocation, ventura:       "481dd6911c6c3f031d0d86f78bf57cf11a079e59e08d382dcfcbce5b76586947"
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
