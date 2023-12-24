require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Zip < AbstractPhp80Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3290c957fa6dc838184b44606a52b60e4eb0b7bd4bb165686d6469509218bfac"
    sha256 cellar: :any_skip_relocation, ventura:       "94f16ba6261e559fb5e16805c9bb40e36a920395edc8f5776b3050bb57907788"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "24ca32fd1533d256c5efbead7d8655b99939ccd2b92c22a9f66a4f7dbe859316"
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
