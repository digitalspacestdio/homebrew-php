require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Tidy < AbstractPhp83Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.17-111"
    sha256 cellar: :any_skip_relocation, ventura:      "bc6f02dc6eb4d091fb7e2227ac0b1d6dc775c16a2eb81b2f721269aeda613888"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "680c2eda82fc7c5db455775ec745d07122d00ff9e92e9745db187a2b8532e8bb"
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
