require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Tidy < AbstractPhp73Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 19


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a55080af2a96dd77780f5d49be52dc14782c60482ac48c994dddcb35678b9193"
    sha256 cellar: :any_skip_relocation, ventura:       "4e4d5f0b3dcc3599915962b5822a9992adbcd6340e9fd6c691d9df0f8f6414eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0879f1cc01d8d68be75ebea781d9556a04ccbb63838b53e64857649f782cc342"
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
