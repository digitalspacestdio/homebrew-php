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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5c970f60ef3ff9261f9181de00747eb7f4fc11d55314f1eef165e88816e365c2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "18fb45df3acd9b89d316672f4c46914629e92031a061e129acafe5817025732f"
    sha256 cellar: :any_skip_relocation, sonoma:        "5905f311fb42ca88dc2dcdbe0229ee7ec965e38254da4793da7b8fde3cabd972"
    sha256 cellar: :any_skip_relocation, monterey:      "7fe2a08f61a8d23ed51d044d3235437c97fb9e2c308a1b30110febf62579051f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0ad962d892051922382dd9f5a4c7d50402710788db871ab6b260a40c920d04a5"
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
