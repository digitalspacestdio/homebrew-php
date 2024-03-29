require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Sodium < AbstractPhp72Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2e01d201eb995253b50a1f2d1c1250ae9dea08350629e3158ee9375b8fa72206"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3353fddc5a567e30fb93638359fa2a7b4ee038757c710bc9cf8cd15cd11b46d0"
    sha256 cellar: :any_skip_relocation, sonoma:        "a2b77f8286f83c82a0f4eaf91684039a132e41a81691e804595a6b994d076757"
    sha256 cellar: :any_skip_relocation, ventura:       "3b9776015a44a1a082f35442873e8e19af57b8cea25bc9a40f37b49e369ff260"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0cbd10997866b3978e41d9452bf9d3424554c0f7c6283c9e7852b19e5ff50b3b"
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
