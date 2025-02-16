require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Zip < AbstractPhp81Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "89c1d0b6638c4e9c50e22e64479b5a4c5a8163ac3625d7ca44bb00f3bc89aa04"
    sha256 cellar: :any_skip_relocation, ventura:       "c996361f1ed8c57bce660643b89b85791f306cdd20731fc63452428864e88767"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3e3688f5348651a222bbf3c606f38a3e61ddf71916b2f6aa759ac46e08a74c46"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "fed489ad0339cee57135d39804f5a865f879539a8ed744203508b41550f36732"
  end

  depends_on "libzip"
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
                          "--with-external-pcre=#{Formula["pcre2"].opt_prefix}"
    system "make"
    prefix.install "modules/zip.so"
    write_config_file if build.with? "config-file"
  end
end
