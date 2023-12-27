require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Zip < AbstractPhp82Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5a4a460088133f180965eb7e080dd39392ccc6a3a66830de02284e42da08251c"
    sha256 cellar: :any_skip_relocation, sonoma:        "ac92b86714999b099f52cdf319b0181f7f00df25daaff4ac0b4b97947b19eb47"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e1cb54b26e6448e97920fc16dfb226fd751e5c805c4bfd921420e6b3a1e14e19"
  end

  depends_on "libzip"
  depends_on "pkg-config" => :build

  def install
    # Required due to icu4c dependency
    ENV.cxx11

    # icu4c 61.1 compatability
    #ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    
    Dir.chdir "ext/zip"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-zip",
                          "--with-libzip=#{Formula["libzip"].opt_prefix}"
    system "make"
    prefix.install "modules/zip.so"
    write_config_file if build.with? "config-file"
  end
end
