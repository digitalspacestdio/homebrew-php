require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Tidy < AbstractPhp74Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 19


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9233991b768465bb12762e5e58aa03e7655c91086435659cb9d926bfe28657d2"
    sha256 cellar: :any_skip_relocation, ventura:       "b843df1a83c6c7afd4bfa028af70a09f3e9ac851fdc45f892eab8a611b9521da"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3bf61dfe254c1410056e35001b5fbba00fc92fe964aff03646982c35c1848dab"
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
