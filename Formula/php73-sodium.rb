require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Sodium < AbstractPhp73Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision 1

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "77204856edc662c37ae8c546aabc2a3dcaa1a15b769522579c42c697ced46af5"
    sha256 cellar: :any_skip_relocation, sonoma:        "cc49c71613537ab9a2b447446f1e34115cc76df4b256ae01fe05ad2fcedd407d"
    sha256 cellar: :any_skip_relocation, ventura:       "1be1df60247c1a040ac8c79a396dc589b6bcdba5da6ae4a9bf8c59a17a879c29"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e020f509e752920347cd0320c6d011df7cfcb039638f1a03c17651d6272dfb74"
  end

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
