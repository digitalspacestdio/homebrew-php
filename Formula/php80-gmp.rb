require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Gmp < AbstractPhp80Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7cce299650bbeeeb646368d1e4bd2f3ce30d7ef051866f917a78d7e37a67443e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "01ef4528d82c1af7f6fb79329b35b20bd8bec13cbe14825b384272d91aab0267"
    sha256 cellar: :any_skip_relocation, sonoma:        "2f322fe4e33b524cbc6556d8448837f57504da019eb15b0cf1450028aa994e8d"
    sha256 cellar: :any_skip_relocation, monterey:      "95b88ef303e0378e27102dd6649afef63c8c332be2edaf948231a284943f1e96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4728c50fa499fb6c042b7121de1a2db8013940b6f4d3fe64ced46759267b7136"
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
