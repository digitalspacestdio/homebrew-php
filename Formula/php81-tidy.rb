require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Tidy < AbstractPhp81Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a33c3e35ed0ad5ded7b14849d3b2a1640717e9d81d50c0a3923110936fe4762f"
    sha256 cellar: :any_skip_relocation, monterey:      "5f09d5c3b8fd8e6a9a5d4cff8598dc65c167662ef8f7080c9ccc9d270910b0d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3957a2cb0079c1e0658243a942a8c47d9774b5627e5d6fc0197bb4b7540f0a6a"
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
