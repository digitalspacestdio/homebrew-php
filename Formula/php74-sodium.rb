require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Sodium < AbstractPhp74Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "22af38035c137944d1c7dbf48125b2c6f191de75c008bb5d8938ae29ded8a9ca"
    sha256 cellar: :any_skip_relocation, monterey:       "eb3590d90b4f24b4c4672dafd231407aa5f968964e524479b1b9969a7cfc18f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c4098667f7698cc0d785cddd27d35c7fb2296116c1f3136338dcb89569215f95"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "25116809d438ec1f193c87097e8fa839c8ea215a99ccef160660992a909b2a28"
  end

  depends_on "pkg-config" => :build
  depends_on "libsodium"

  def install
    Dir.chdir "ext/sodium"
    ENV.append "LDFLAGS", "-L#{Formula["libsodium"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["libsodium"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-libsodium=#{Formula['libsodium'].opt_prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end
end
