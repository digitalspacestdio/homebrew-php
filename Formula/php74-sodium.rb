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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b62aacc380af17aff8217be1b877f56727ffa4e11ccd377687145eaf44c17f56"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3de96e3c1869b957dec8d1af858addbba16c9647a6ece4ae5e7d24611a1500c2"
    sha256 cellar: :any_skip_relocation, monterey:       "45e73dfc773d0d9c6a0db7dbb65d234d258a8684d45389a4b6adfd0af77654e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e1107c8cb501185f8ae5dcbc8c99c5d79c3ff5e90b94e26ad25e0b70930d0105"
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
