require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Sodium < AbstractPhp81Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "53e9b18bcdcd28e5befb479fbb829e65171cecd8416f96838fd904f0999ef728"
    sha256 cellar: :any_skip_relocation, sonoma:       "354e946d8bc7e7b3675d7564030958e1396f8a20b9500306cee0d2a2bf3d9bed"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "64a577d4e47a4f92eee5ee0a2163c25985f142c49e6edef4f9054989c4543042"
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
