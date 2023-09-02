require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Gmp < AbstractPhp82Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1d47c1f37123a80bb565ce90169fe6341f584c12cee5f50afdde2d6b7c9c4755"
    sha256 cellar: :any_skip_relocation, ventura:       "80f51c77eb5696eaf557f4df3f485d549f773abbc76aa793008db1d2bc39aa12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d7a9b1f873175f98a974cc99b730421721b8ec1ac788585ef07f4324ae77991b"
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
