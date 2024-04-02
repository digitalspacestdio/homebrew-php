require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Sodium < AbstractPhp73Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8ffc9105e3266a29b76f1f8c50418be806e899e0ddb6b9b196f53a60a10bc4c1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "239f0e51043cedb357c4841cdc0e18ab83067658eb0d1ef0f96a189f166fe06f"
    sha256 cellar: :any_skip_relocation, sonoma:        "5e4c46bad56b6ae90b95177d5116fc3a4f01cdae989abd6f2043d79915441513"
    sha256 cellar: :any_skip_relocation, monterey:      "4a1492a106999bbe875719f6a3417ebb83f07d372dc4ef076a530c52e04a9c33"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b0e1ecd5f0ad3b5daaeb2394f74483e8046f81f7bfa3fa7ab5815f2b8976c58a"
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
