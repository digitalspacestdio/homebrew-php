require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Zip < AbstractPhp83Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2f18301bc757c4cdab655d081b3eccde5b0f5c21ddada34f12917e7d077320ed"
    sha256 cellar: :any_skip_relocation, ventura:       "553c7e064bae4eeb248997c123cba9447fbdc790184ac413e534c0aa34b9c9b1"
    sha256 cellar: :any_skip_relocation, monterey:      "8c48d3180a1db50bf56feebb7c367079378ce2b2ca5e6147b74a9c546ca8f580"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "56f8eb8ff4cb5df242b0f5716939cca80a5a6c60eef0b319e31291f8b787b781"
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
