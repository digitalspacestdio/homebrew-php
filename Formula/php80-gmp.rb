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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e39266f71217dbaa9cecf19e6efaf0cfdc31e691c69e6aebb5f6384c0aeb1a34"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4729e8d7d90f33e05beb51383f725df870ae02cb18f419b11031352d6f60006c"
    sha256 cellar: :any_skip_relocation, sonoma:        "2f322fe4e33b524cbc6556d8448837f57504da019eb15b0cf1450028aa994e8d"
    sha256 cellar: :any_skip_relocation, monterey:      "d4badd2dc6e903e898cb4181ab4ace8111702dcf6589fa8acfc7aad7804c4da7"
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
