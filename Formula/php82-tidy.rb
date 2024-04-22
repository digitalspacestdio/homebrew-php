require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Tidy < AbstractPhp82Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d03457415462aace34700ad79128659676e46cb705ae5b8eba80f868cc99b53f"
    sha256 cellar: :any_skip_relocation, monterey:       "01392f918989de78f89d5426a9ffdd2e353d46c64eb47d186f0deaa083dfb8f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6bed6f8b44df3ec7212086e13c865c72d92dbec9a96479775e5db636bf544a2d"
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
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
