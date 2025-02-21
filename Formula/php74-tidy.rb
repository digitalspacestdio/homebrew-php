require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Tidy < AbstractPhp74Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "55f695d6efb1dcd2ed974d45856afd7858d92094fc719d4dc67e67d8f9923e10"
    sha256 cellar: :any_skip_relocation, ventura:       "364c84b4ded8d89b6e8d066088452e688c8a2f7180e8df67b8e29d023c6e57c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dbffa7ad6b0df41f8e2308fd445fe8eaf10651e10858fe714fbb8867dac8f315"
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
