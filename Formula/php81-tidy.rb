require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Tidy < AbstractPhp81Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ad85d360d21d36f147e4417bdca5fddcfc6d0dac6097b7643cd137d0f80b356c"
    sha256 cellar: :any_skip_relocation, monterey:       "619f710cb38b1cb832c808272f43e91b521f6bf009846c9274383914af612039"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1abbdec60fc3286f694c5628aad58a2f841c3aab511ba3972f9a63e16b356ca5"
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
