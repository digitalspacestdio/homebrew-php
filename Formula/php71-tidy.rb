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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b725335e47f9c2bde2ad32f896bb3f131a42fffbf144cdae4f94945722d68b31"
    sha256 cellar: :any_skip_relocation, monterey:      "09759ba94867deb79ed850e27250289763236223137f8a8b42f43d50da23d0d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "90f9fd316dc44d39572be69fe469ed4751db48284d97201a9e839b2926dec761"
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
