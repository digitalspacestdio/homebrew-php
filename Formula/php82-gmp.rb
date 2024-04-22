require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Gmp < AbstractPhp82Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "023776bafb69afa465cd06095169ca35d65228e9b0e33907065032ffc655466d"
    sha256 cellar: :any_skip_relocation, monterey:       "3e2f1a8585878df6e429042fe547728f54c4e28bb1030c1c9b8482f5927c8594"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eb5468dd00cea2e1a581565aea1df6667545e6cd86dcb5656ce10f90cc640513"
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
