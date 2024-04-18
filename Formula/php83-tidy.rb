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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "519ed43d3b8fdfe389cd356349087381a4ba2f472550fc824398b7172eb743b7"
    sha256 cellar: :any_skip_relocation, monterey:      "ea3add80dd6a48c536b5229dc84241e232390803c0a4203417dbb54725b1fe29"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3e5ba206150934d0ea70698c1389efa0dc33700bb99eb30287d210a4343fe50f"
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
