require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Tidy < AbstractPhp81Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "257dd29d8f14ab9f1b3e7f427267baa4b54d43dafb0a178bab53b8881f592065"
    sha256 cellar: :any_skip_relocation, sonoma:        "f46fa5d310fa2e2b8eaea442770c05ee84d1aee37a23abf14b81f911d989805d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2f77f33deadd269b658a83586e1492ea44f1113dc832e1e10de4f2c18cdf410f"
  end

  depends_on "digitalspacestdio/php/php-tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["digitalspacestdio/php/php-tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
