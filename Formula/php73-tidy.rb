require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Tidy < AbstractPhp73Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8b520a3537c57927132c25b34f395675c9caea9773dcc2dce5afa44f8f39040b"
    sha256 cellar: :any_skip_relocation, sonoma:       "6bfedb199272d70016ccfac16c90f22f6e20dde6343c29325af3badce4dd474a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e5be9e59a8d4a74576f17b040bb201da40533fdb571e61c758a1d5492c47cf67"
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
