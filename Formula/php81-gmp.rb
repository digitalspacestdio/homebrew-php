require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Gmp < AbstractPhp81Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1698fea42b27f6dfbca5431975216f08fa15ebc197b46e2fb8b7725141e54cf8"
    sha256 cellar: :any_skip_relocation, monterey:      "093bcc84725b5cc05fb77bd7769be78cbe832bcbb690acf9134b248e0eaf2c69"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c01af86e051d240531997dafe428bf0e7a6120344e56a16675d325f5fa6fdf63"
  end

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end
