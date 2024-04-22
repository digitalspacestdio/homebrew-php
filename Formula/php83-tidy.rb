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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "54ae52c781487bc1b2f999e87b8322ab22212e0663385296edb3a9850b7fd048"
    sha256 cellar: :any_skip_relocation, monterey:       "9c404cf4f89088e4ddebd4454c3cdb88fbd00e8312fa1d2dd98bc45bf90168ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1f20aeb7d526cc560c055ef40c8de95978926186de4f99c0e9d2f4936d387788"
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
