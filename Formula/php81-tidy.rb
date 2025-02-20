require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Tidy < AbstractPhp81Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0e431ee6825af31227ded6af8125e0d065b6551713a967221d84385596ee2913"
    sha256 cellar: :any_skip_relocation, ventura:       "b0fc875c9a6b951d668d79fccb3b41d796ff65c8210312b2b9a3326eae98e570"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ddb5d9af533276808a49b97e1b3efc01122f24bd573cd1935e9c131ef87f5696"
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
