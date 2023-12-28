require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Tidy < AbstractPhp80Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 19


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3fccfcdb240c1737a9d3e937b689e8a9b797aad92297b121c4ae65053aa52d9d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8986ea520dffef507210f320720165c3aa7decf28b1b9bc3aefd38de946a5fe3"
    sha256 cellar: :any_skip_relocation, sonoma:        "67619ff1265cd2245a80d4d31336c8acd25a9ff0fbc0c39f6fbeb17cfabeb476"
    sha256 cellar: :any_skip_relocation, ventura:       "4ececf0b0a95549e6f576491f97542ff8753d9ba4608832cb36eee0c6b579e20"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "998a5d078f52b7671455eb9bd15f31a74571730b899e523184676f29e434de5d"
  end

  depends_on "digitalspacestdio/php/php-tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["digitalspacestdio/php/php-tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
