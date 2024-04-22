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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "00c9e6b1948e16348deaaa990099937c07723a859dbc5170e1f76c72e43af6ee"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ec7e9b923f8818d26fef4ac8e219a422e9c30d6fe7294468cde884872bb9d9ae"
    sha256 cellar: :any_skip_relocation, monterey:       "acf2cbbe8a18e4c676cbc1cc268e9e57483a8f5f023824ddaca14fc6bd8f4849"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2798fbc67e3009276d21756ad1cbf925b67a18d62a25e9225dea125784ec3b53"
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
