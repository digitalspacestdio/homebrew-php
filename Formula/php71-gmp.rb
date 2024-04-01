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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "af6c387cdbe225774787415bb1bb4c4005bff455d4f1d8a142ee5fa5d7b35cf8"
    sha256 cellar: :any_skip_relocation, sonoma:        "027589f90a40d4a835a89efbfe525284834d1bb7ef8ad0bdbca3891c44868bb2"
    sha256 cellar: :any_skip_relocation, monterey:      "708318e646eee4223c445290b1e88508df0a9e5879290233e2a6fb3693aa0be5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9ba7bc564858451b93e0ea6923bbceb5801ca79024b89d4a4a536ca34c26722f"
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
