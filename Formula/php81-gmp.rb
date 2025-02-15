require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Gmp < AbstractPhp81Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d7a4172c5039c3dec9a04a85fcd7da0c7c13346d7de9a42e69c7642165452a4a"
    sha256 cellar: :any_skip_relocation, ventura:       "8345c509827ddda764a10357f35e91422cbcd57f88b93430c96bd3e60898545e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0080cb5ec1816d6dc91a9a4c6d3af8f4b7fdde6e828c45dc4766c85c95da7a87"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a8d0afd5b8253eb0aca1fe6fe959017680edbf3f4c32521294c452c0488bc02c"
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
