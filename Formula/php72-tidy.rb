require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e8f3d176d4cf66436e0f796ae90782cd6a1f7b40a68ac962311f1a1c90aa182c"
    sha256 cellar: :any_skip_relocation, ventura:       "6c85ba95a4d53e46e7f8ebd4703fdb7f606d9cde499fe04fb369e549f896eb78"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "92bffb2c54b1eec159297a32bf640ca7b8bd61d92056dc0ea58fd2633e559cf2"
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
