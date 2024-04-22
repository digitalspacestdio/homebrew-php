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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1c5e74f9c1983aadc6f9423423f366f8b9217da04ba8d321710b7fcb865721b0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fdbb2d69aa18dc0daadab15462d16da87e55f6a2dda4e16ee0db6cb3b0238294"
    sha256 cellar: :any_skip_relocation, monterey:       "5294a7bf0835a076b3e28be7c53b3406265004efdc89c7b3d9712f14ced33338"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d564873d835c8af3734b96d1994eaef4404f7fd4934caf7f9593bd6537457e9e"
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
