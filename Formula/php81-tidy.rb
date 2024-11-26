require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Tidy < AbstractPhp81Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3b7af0f5438b9965804d942239daf974b31512a8c2ab327b6913cfc71f20b28f"
    sha256 cellar: :any_skip_relocation, ventura:       "84a278f80cd2d79cd7d6cc4cc5af6c1514647e184380d09910a429771d6f874b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "af9b3f608673efaeb06a8d0241d828ff37604b0d415639ba6b1d9176d09f2936"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "75c8acd5012825a576af3e8c41c2732e7b7f1eaa6828fa7a2f26c4f9e0f8222d"
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
