require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Zip < AbstractPhp72Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "adf8be2d09bd717734dfbdf96b7e5a33d0a5f72c158c64adba8e6e35ab61177d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "02e129a4fdbe3c7b45bfd992da3d58a7ca5b53a807bf7e5da0c45ed979b057ab"
    sha256 cellar: :any_skip_relocation, monterey:       "c50f96ebd4db18ef5b64acda55fb832b2822b5840cd8a4c69d1c50340bc45c94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d8976e091fb97c230853a3e6ed9b1de8fc24afffc8777b6c9448bca7063030d8"
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
