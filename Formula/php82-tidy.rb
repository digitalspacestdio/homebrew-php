require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Tidy < AbstractPhp82Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4c8b2ec81792f47b0840d2d3b251c16973fb5a4e0afdfaa08f38b49980d90152"
    sha256 cellar: :any_skip_relocation, sonoma:        "1a4698b2a2039a6537b0bef756c6f60ea01db8c8284a8a4e945fd59758ebf344"
    sha256 cellar: :any_skip_relocation, monterey:      "ca3aac6e9c2d32680b38a6b32362870d5261f852a304145f80d62fbcad271bfe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3482c1ecac1f2c24c0d34b3d03204830f06f206c858529631ddc552b9f6f49a9"
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
