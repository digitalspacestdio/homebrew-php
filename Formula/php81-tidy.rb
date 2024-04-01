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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "149f5d469f1f3a29076c38fb0ead8e3ed209c6284c915bceb8c136816f72e087"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4a3dc54fb79041e8b809d96bd6888fe80c62049a2ca6e9ae09463e20f5834290"
    sha256 cellar: :any_skip_relocation, sonoma:        "d32a940cf4a81817854b00e7a0e20ec7540ec2d4ca31261994995ded3ecc6895"
    sha256 cellar: :any_skip_relocation, monterey:      "7fe2a08f61a8d23ed51d044d3235437c97fb9e2c308a1b30110febf62579051f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f48bdd268af878969735307a7641f29b46935be84a994eb7d2cb6ed624b887f2"
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
