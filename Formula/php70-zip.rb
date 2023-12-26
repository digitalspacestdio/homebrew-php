require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Zip < AbstractPhp70Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision 1

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e8cee18047dd2321824d873f824f98fe4c2fb88dc6a8886b61f9e5386749da24"
    sha256 cellar: :any_skip_relocation, sonoma:        "7c618f06f2b7bef95f497ca842d52343c6613e25898d427a43c8b60e1e474162"
    sha256 cellar: :any_skip_relocation, ventura:       "bd9559584d24f0cbf0286dc4e4b77ed9822bb0fe17ce34aef9ccc027d9f2261d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0c97762936d0e13629bfea879e2e2d1bf4cf4b199f112f029153e2b04d25b07a"
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
