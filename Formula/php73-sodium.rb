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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "104c36efcee2e178d56acee1ff9bca5a05cd22a3fe111137fb7b534ca203886f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b7daf95d7a8dbd713d4446fb633d554a9e923b89846ce24ea9e2d68ee5a0ce30"
    sha256 cellar: :any_skip_relocation, sonoma:        "cc49c71613537ab9a2b447446f1e34115cc76df4b256ae01fe05ad2fcedd407d"
    sha256 cellar: :any_skip_relocation, ventura:       "1be1df60247c1a040ac8c79a396dc589b6bcdba5da6ae4a9bf8c59a17a879c29"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7120a4333aecddfee010f0d0a2e50f854309c7283e486186e9accbfb9630c775"
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
