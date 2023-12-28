require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Sodium < AbstractPhp81Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision 1

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f739eefeccf3b7a16bf97a2186e0fada7e63ea0d34bdfd74857daf8ac86993b8"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2d040f96e28db4ce865a9ecea2851c6e50d1c997cd32020b21bf31e702af8e32"
    sha256 cellar: :any_skip_relocation, sonoma:        "beb2acda0831777b9d7cd9afa8bcb917d387b3a82cc0225d482621859266d482"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "607fd9493456cc4c6700804b28dcbe2ff41ea89bbfca28b5da70f33e6972a515"
  end

  depends_on "pkg-config" => :build
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
