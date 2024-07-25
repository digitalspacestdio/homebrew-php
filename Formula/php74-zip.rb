require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Zip < AbstractPhp74Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2237e768034fceb7b651a633195f4f180c1f934938101cb8df55413ded9af8b9"
    sha256 cellar: :any_skip_relocation, monterey:       "b7759ca9364e03013e71fdca6ff5c412644db3afb1eb0c5940a144a91eb969e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ee36e20ea0a6a410e6f6198f5d33a646885fd39416e7c61995e1989910aae119"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "ff2042b982e78f9b66f38f2d9cf15924d0915e6300aa7916461cbaa465406732"
  end

  depends_on "libzip"
  depends_on "zlib"
  depends_on "pkg-config" => :build
  depends_on "pcre2"

  def install
    # Required due to icu4c dependency
    ENV.cxx11

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"
    
    Dir.chdir "ext/zip"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-zip",
                          "--with-libzip=#{Formula["libzip"].opt_prefix}",
                          "--with-zlib-dir=#{Formula["zlib"].opt_prefix}",
                          "--with-external-pcre=#{Formula["pcre2"].opt_prefix}"
    system "make"
    prefix.install "modules/zip.so"
    write_config_file if build.with? "config-file"
  end
end
