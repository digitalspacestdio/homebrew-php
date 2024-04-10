require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Tidy < AbstractPhp74Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "92802e4c84c9cff1940b4fee6e507cb8e103191db4fa0c6523fbb174b6f222f5"
    sha256 cellar: :any_skip_relocation, monterey:      "9f8755d531e5edf10bbb846584fcdd91e119defe3b7baa95c85fa92c6d1d47d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bc762e3f075274ba99e4db0945048e13c65663a994f7b42f86e055b4e4ef9e38"
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
