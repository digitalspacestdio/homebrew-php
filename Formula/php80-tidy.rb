require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Tidy < AbstractPhp80Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6c937e26e836aabcab4f04cb48b4e4594cea57c2ac1dcecf5f97bc2a6f960094"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9f7955366b2fd36ee3a402e1b102d7f00663a4ca75db5ea3603c06023779b824"
    sha256 cellar: :any_skip_relocation, sonoma:        "0ec325df89e14e1609536fb88ca9e5e58447dacd9556030d730966772cc9fa5f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a7973483d7bcb545fb7457b601000a9d29cbd52b5e32e08a2d928298f0566caf"
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
