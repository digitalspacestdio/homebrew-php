require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Tidy < AbstractPhp82Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b2370e9630c7de0af699bf2f427246b235108d269821b91688afa1743cb6c8b5"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a9d62c4a755b84fb84fe7b56eeb39a315bedeb1c4b2dc5a05b2c22c9abaa5e9d"
    sha256 cellar: :any_skip_relocation, sonoma:        "19865f619561aff3f2c47cbdd2c12daddd2baf0e364c3caa0bd3867272c30dc7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9d5419d9418f217183d58a759796ac855e7b5a8a4158f8f95a3ac2c9618e86e8"
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
