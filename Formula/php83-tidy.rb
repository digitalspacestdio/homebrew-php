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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3f4ed351fba085892cb5932da15bfde6f89c4a0356a152fa6dc7093b1c1fbaa4"
    sha256 cellar: :any_skip_relocation, monterey:      "c6ec45ebcebb31f12e907a5d311fa23b8d696036a5d02a67d96358479ada0104"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a64aa55bdf8a1c307f84fa068b002f6e6ed160878e4462a050ab3d5a6574f100"
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
