require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b725335e47f9c2bde2ad32f896bb3f131a42fffbf144cdae4f94945722d68b31"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "51bf957a463d3d14f650bbb0bd40232bc7d73163514af33a910b5c6f3c7d566d"
    sha256 cellar: :any_skip_relocation, monterey:       "09759ba94867deb79ed850e27250289763236223137f8a8b42f43d50da23d0d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bb44d245f19b1a2c17c767c1392b9c98b854dd409cb8b392fb39b347dbcb6342"
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
