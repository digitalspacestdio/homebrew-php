require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Zip < AbstractPhp71Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ae2c63ac52722607aa092272cb5c1e35fc7ea9533915bb5b694d9fac210fcd88"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "73830109da2b5eeb4297bb60ac80b263aa59c8eaa38bc925d9a9702d30574a38"
    sha256 cellar: :any_skip_relocation, sonoma:        "fb188245250172fa1a69de533fd321a74a1a2f47b66f348f9761fb08a3d3152e"
    sha256 cellar: :any_skip_relocation, monterey:      "ab8e76694464ba0403fd9abd87161490b56da6a40d4e085bd3253d981de185e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "da20c74e303afaad23332afba54eef39137a81ad6290e8640d23216426993e60"
  end
  depends_on "libzip"
  depends_on "zlib"
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
                          "--with-libzip=#{Formula["libzip"].opt_prefix}",
                          "--with-zlib-dir=#{Formula["zlib"].opt_prefix}"
    system "make"
    prefix.install "modules/zip.so"
    write_config_file if build.with? "config-file"
  end
end
