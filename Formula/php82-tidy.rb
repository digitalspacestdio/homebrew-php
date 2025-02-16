require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Tidy < AbstractPhp82Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.27-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8fe67e456cb2ca43cef497cdf306e5f56cccb6760f7f912459f8e870363e419a"
    sha256 cellar: :any_skip_relocation, ventura:       "cbcd98b40f24ca5b99e12c46134f47d2305aef9f7920ccf0302a9f13a735eaea"
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
