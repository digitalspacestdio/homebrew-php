require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "25ffd3b17f6aa6de1948c27755f46f7dac92f7cc504b6f18bf11a6011d0d034f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d24c8047e1383d145c9aaa5fcf4d20f2e02bfe9f5e5dbe7ff8ea834cc3c207fb"
    sha256 cellar: :any_skip_relocation, sonoma:        "239674e30b4af9904aea84c04b1bdb68eba7906c5f08ee7e74ab2b6f045fc84a"
    sha256 cellar: :any_skip_relocation, monterey:      "183f9e0fdecc101fa5a7ef61bb280256e7463544945822d288a413daee3380d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3266c21cbf2fd26e8c5f61506588e49754f9e44e8a6fd579bab376b072db0597"
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
