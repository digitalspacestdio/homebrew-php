require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Tidy < AbstractPhp84Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0beta5-100"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d073f4d2a543459d77f82395e93734d49d372ceb8514889db1c4ba577b7c5a36"
    sha256 cellar: :any_skip_relocation, ventura:        "342e5e7f42b5a3cd5e9b5c55a2096819799af749798eb0e4ff8b79165d18ad4c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "51bbc127639309f19351f89a943f000d7926533214c5786f1df573687d8f8d1d"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "add473ab7d381d20cf4ee061898abe53ff1f727e8191a94b7638d2ee67c5f6a5"
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
