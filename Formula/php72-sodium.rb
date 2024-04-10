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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1c5e74f9c1983aadc6f9423423f366f8b9217da04ba8d321710b7fcb865721b0"
    sha256 cellar: :any_skip_relocation, monterey:      "2c0b2bb83b949ce5aa53fe607b9ede3fc887997b5968f1d215fc7d21638767ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "00c0888677784f10347bbd1707c0d8ef75e1742d8e722ef3d5ae4c6124279207"
  end

  depends_on "libsodium"

  def install
    Dir.chdir "ext/sodium"
    ENV.append "LDFLAGS", "-L#{Formula["libsodium"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["libsodium"].opt_prefix}/include"

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
