require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Zip < AbstractPhp56Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d78b3d815bc845d8937330ca639a3bb6fe9d6d8a26bb473f3659474e475c6402"
    sha256 cellar: :any_skip_relocation, sonoma:       "47a931036007e4cad14fa38c75f24f2c9a94fd3bfa7ecc694eeff2d27ff1a76a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4fc35d0d6ad3cacc5c5da2695167704c261120f989da4da4f9f0b337da56bae4"
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
