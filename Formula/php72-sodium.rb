require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Sodium < AbstractPhp72Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision 1

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "386b3859493deff17941212e050c5773855f8261f83e7a76b3c68d96e085fc37"
    sha256 cellar: :any_skip_relocation, ventura:       "3b9776015a44a1a082f35442873e8e19af57b8cea25bc9a40f37b49e369ff260"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bc71a2b94b8abc8820c08a7e9bf51b9d5de0d2fee7180bc05bf12259b0caadda"
  end

  depends_on "libsodium"

  def install
    Dir.chdir "ext/sodium"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-sodium=#{Formula['libsodium'].opt_prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end
end
