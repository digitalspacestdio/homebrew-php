require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Zip < AbstractPhp71Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision 1

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "65be5910a5063fb9e6a6607e3e6e93207344b50c41f28903efea0d8699681fa0"
    sha256 cellar: :any_skip_relocation, ventura:       "7ae7982e69e86e25f9cabcac0e56455fadde467ade0b31f77dde995a914274cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "be286a0b4b9b28f62b3961819c4a1813d91966cbbca506c3729523a292afc18e"
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
