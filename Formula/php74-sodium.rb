require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Sodium < AbstractPhp74Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "977d18d5231f1bc290d8364a8bda8c55404c66e29831dc657348f8fd43307e29"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c9fc155c5e01c8a16860ec1051afec0a41dfdf4732f21acc67fe434f0ae95a87"
    sha256 cellar: :any_skip_relocation, sonoma:        "5b89d01f9fdf9f6bb233ff295d15a3f32c0d94cbd6dc378b32c0b85d45c0e39e"
    sha256 cellar: :any_skip_relocation, monterey:      "4e8a2c2c6b17043b8ff1a87c3648478d805370773cea125daf0d534429df14c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "62af6bb6d80c96a4b3feba21e3db5eb763c6f0c1bf9ac9debab533a28f9c9f4b"
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
