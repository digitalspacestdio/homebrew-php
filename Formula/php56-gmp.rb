require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "501ae89f458ad9853ede497b9292a5a3a5e7d5fee78b68f7ff9a9a2310a4c784"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "97b009d1307400e5aafeafc01599deffec36e4572b4fe4705466ce691c868e93"
    sha256 cellar: :any_skip_relocation, sonoma:        "19786b52517cab6299d3330b23a4524b240929ca23acc1d4cb45b948b57cb511"
    sha256 cellar: :any_skip_relocation, monterey:      "afa1d1270cfb6625bc56b4e7ea4e436c3a63113fc0353fe0da29c4003a0d6076"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "547b25ad6ba11d24701fa687dea792653d99f5d75832b6dbb6a23ee225a5d6e4"
  end


  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    # ENV.universal_binary if build.universal?

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
