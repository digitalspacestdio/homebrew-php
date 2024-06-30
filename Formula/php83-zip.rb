require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Zip < AbstractPhp83Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.3.8-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c68d7fa2c806303783b43515cc31bd075bd42e59bcfc113b001edeaef6fc2d76"
    sha256 cellar: :any_skip_relocation, monterey:       "399f78d75884a96baf35c4702ed214c5fa4b61e313cd94229d4ebc0633e29362"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2364c3f8722ad2a3e096632ce9bae7050deb092d6d4f1a0ec04d46509b1cb764"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "aaa02dd0d1d42cd259759c5ada4be40f7630274c5aabd2dd9a9987dcbb844d49"
  end

  depends_on "libzip"
  depends_on "pkg-config" => :build
  depends_on "pcre2"

  def install
    # Required due to icu4c dependency
    ENV.cxx11

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"
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
