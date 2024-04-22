require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Zip < AbstractPhp81Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "498a140701b58e68841ec80864a093992ec6be30161919a050799c55418721bd"
    sha256 cellar: :any_skip_relocation, monterey:       "8d66d43602b2cef2a47db708d8bdd7e587cd798320d3736334230b1a055488f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "98b1320396d4f000bf34b53ac3ec9100ca6ba91590b972653bb1222c1964c8bd"
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
