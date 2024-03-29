require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Tidy < AbstractPhp83Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cfef8ec8c980979ad9a3576424d8e1474f9206ea0abb83f24bd6f48c64e1ab3e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6d403a73fd4fcbfab9322722f7654aa1a6d1fcbf0c40eabb1685f25e108283c4"
    sha256 cellar: :any_skip_relocation, sonoma:        "0856628b9e935ebde6524d1bcb092900be4b6f126758ff875a6bbf76dc3e477b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "081cf91fc28ef9338e65e377f4e1285f3fb696e912a3f3c42a9fdcf55929ab63"
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
