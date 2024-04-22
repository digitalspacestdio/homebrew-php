require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Tidy < AbstractPhp80Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8befe3d19debd6965b09b200524a29e353b5c4a0b21df0f0880a2ded7a672ba6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "49f5c861b4907387dfb4fdc6a4981d7320d3b04bb9f35586155cc701b6c37405"
    sha256 cellar: :any_skip_relocation, monterey:       "f7a29eb32dc6a89d5a06483f25b359989e9efa7b6427e42bf527e24d6fd107c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b4ea0197a955fe10a68dbd1b4d665f5b1ea3556578636ddc78b9194bd516606e"
  end

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
