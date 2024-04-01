require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "23d5fe14d134f841479c940363a7fb68977ca2dfdef7f476a6f4457883f18506"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a9a04e48ad924c357d076a46d13f09feef4f3c11f5dbc6442b9f1b3c7aa91a8a"
    sha256 cellar: :any_skip_relocation, sonoma:        "86501162dce249cbc2069301b43e18f5be90e344906ffe837484adbc5a26e927"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "492799098275bc8411271c9116d497dc3d23324765f21ac882a90b9d34c8c870"
  end

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end
