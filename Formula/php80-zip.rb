require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Zip < AbstractPhp80Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0518fa7e1993eeb7cb94dce80bed8651bd621b7eb88fbffbddbf0c95cd7e3646"
    sha256 cellar: :any_skip_relocation, monterey:       "9ae11d43639ea43e22234a6366c3565f9002928c3991307fd1820700e47bae2f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e8a1575d7f932cd1782329f867c2173d46bcd6d882c76703b4e47a90d6d4ea56"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "45f144402de66a05de82817ddb1071219b577a99795554a194bd8643c33440af"
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
