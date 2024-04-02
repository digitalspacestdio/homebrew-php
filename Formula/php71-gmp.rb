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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a3f41a5aa0bc95995faf3837243cebbb58d17276f446561760d39790944a5c9c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "af6c387cdbe225774787415bb1bb4c4005bff455d4f1d8a142ee5fa5d7b35cf8"
    sha256 cellar: :any_skip_relocation, sonoma:        "027589f90a40d4a835a89efbfe525284834d1bb7ef8ad0bdbca3891c44868bb2"
    sha256 cellar: :any_skip_relocation, monterey:      "fde8f13748e95b1fd1ec71c131df20b6ad899a70021dd2fbe0f70889a7d4e495"
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
