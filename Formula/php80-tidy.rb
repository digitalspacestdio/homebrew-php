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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "11a62b524e7ab59f9c824fc678e570c4e13850323366cfecb93c4064847e8aae"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "048b6581ebb3acd8812635ca45c6b2be50f79c798c1bcc6a7ec49788e887a6e2"
    sha256 cellar: :any_skip_relocation, sonoma:        "0328788b7fa9098452a4fb3edc66b0ce4c69538a36b7228d23f5e9f816985140"
    sha256 cellar: :any_skip_relocation, monterey:      "2096213225be2ba8c76d85309cbd4dc730ab5792ef46dde06ac508632031bb7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d2b2f925df64b79433a304c1a3e2ede4fd9234a9919c2ce01f351afaf0a43e19"
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
