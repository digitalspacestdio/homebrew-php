require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Zip < AbstractPhp56Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/5.6.40-104"
    sha256 cellar: :any_skip_relocation, ventura:       "42494e4686340aa5db67c464ebd20ac7419bc011433954793bab3881dfc606b3"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "be54e5b74d9bb7b6bd84919c137983b971381912f8e938a3c58a713965b969ca"
  end

  depends_on "zlib"
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
                          "--with-libzip=#{Formula["libzip"].opt_prefix}",
                          "--with-zlib-dir=#{Formula["zlib"].opt_prefix}"
    system "make"
    prefix.install "modules/zip.so"
    write_config_file if build.with? "config-file"
  end
end
