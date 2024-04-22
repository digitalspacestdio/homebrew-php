require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "36b533e617658b6cd77d38826413fdd571b3c25db1b7807667013e3c7eed23f3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "faba477ad7264ef4d59f7be364a4aeec4c1506bad72072aa97304ae62f5c2330"
    sha256 cellar: :any_skip_relocation, monterey:       "97cb186cdb5533a27058636f20454446ccd422a7c265a24ebccf165c6b8d5618"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "15a2d26c0d9295c19e63bb70c14fd51af9eda986314fe4a408991f805354f750"
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
