require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Tidy < AbstractPhp82Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.27-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "fe6fc4f7f5a7ac6ccf46b5960167918695ba2b6b04d0efa30bc1e73c0a1f42af"
    sha256 cellar: :any_skip_relocation, ventura:       "7cbbb595219ecaa411da18119c1cd1044ee8952a5c2ecef7da3f5a617ac8fedc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a1e6f4ae212afb0ef4c52b924163dbe4296ad93ac043fdd0691e112ab760da1"
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
