require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Tidy < AbstractPhp73Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 19


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ffd9fc46b78d9c720ae6b735dd82f21e89e196877fa4fe38413af72afb91e5b4"
    sha256 cellar: :any_skip_relocation, sonoma:        "a9c214a9ba8295fda9bcca3f232f387023a2aef123b97c61cc99f74ae1c7dad0"
    sha256 cellar: :any_skip_relocation, ventura:       "4e4d5f0b3dcc3599915962b5822a9992adbcd6340e9fd6c691d9df0f8f6414eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "be940a8df6eb5cde07b547a5e078e776357fa5d1ca8fcbd7fa38067a93097114"
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
