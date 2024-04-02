require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Sodium < AbstractPhp80Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cc1bbc7a419782e3da121f01c38c95a409b48cd184fde5b767d5fc7470f909c1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cef72b893727b807f5928b59aa527f965baf5df4fd1025e0c9c28a57ffd0feb0"
    sha256 cellar: :any_skip_relocation, sonoma:        "fbe92e1ed1c83c008d7c714303320b3d46ef0805263b0caadd708cabc6bd2c2b"
    sha256 cellar: :any_skip_relocation, monterey:      "201d968fddf366f3e3d1006758c37ec176a007ca5b0d57e93c58f4a0ecc181f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "204ada28b6bbe611930b06f7946ec52910539706bd95c94c1e9766a0853db7be"
  end

  depends_on "pkg-config" => :build
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
