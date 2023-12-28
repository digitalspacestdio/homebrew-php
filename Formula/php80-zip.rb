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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "765e77078454a6de53fb09e169d7771acad80da67b1a31dcf3a34c7dd320358f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "603667799b583ccedfb6e822c91f6386c42cc57653320236419720a91018c919"
    sha256 cellar: :any_skip_relocation, sonoma:        "f1765d3febdc998f3f733083555efd6fd532a13c016d82d7b30df04fe217ce9f"
    sha256 cellar: :any_skip_relocation, ventura:       "94f16ba6261e559fb5e16805c9bb40e36a920395edc8f5776b3050bb57907788"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "900c3a69b9ce8666d03a37a69d5989bf106a0cecd11ce0f5d16cdf8aebed5307"
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
