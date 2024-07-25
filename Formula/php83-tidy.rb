require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Tidy < AbstractPhp83Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.9-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a6afd62e0c3afc5616614c41e13de299271a09d0548107071bc876a2a9ec3a26"
    sha256 cellar: :any_skip_relocation, monterey:       "a3b5897a18f551038062423bac03f6b32696e1621ff40a0b82c73e53bdbea258"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d46690f3f97ee3e42a4515a1256e38a348dd6ba3512f981c939c3ef44c9f1d06"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "8d8f51116baa2a221dcd5b07b43c7c4dc370dd6ac07ff5508190fff73d4d55a7"
  end

  depends_on "tidy-html5"
  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
