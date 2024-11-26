require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Zip < AbstractPhp74Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "957718a9590447ae5044a193fb5fd1c765d4d282dedbbe6119adde62cd749960"
    sha256 cellar: :any_skip_relocation, monterey:       "a5bb5b2826c0d4597dde81a7cf9fe17747c48451f3f5ed143d5dacbda5d0b974"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "95953e93eee8d6c969633354f04386ceb7499e0fe90d3b247144f91d9997f72e"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "fb6731d0a24330a0f822765d6f59873e9f549117286ba55af062f77e5360be9c"
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
