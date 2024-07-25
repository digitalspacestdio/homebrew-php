require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d02f5f7a43a6e7d93fbf549ffd0df1e99d31d59af4d357f2f2e17107dc8afc76"
    sha256 cellar: :any_skip_relocation, monterey:       "0d097c4c0e9602e8ed0759a325f8bcd2c69cb6cd7a297720e0d9ee264bc2994c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "37e4be7819eaafb4c796003b8022c6498e32cca141cdeb9118346ff7df2fb512"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "38b26328747c9eac965911c405b1393914d41bd1efd2023d1120f441730eb489"
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
