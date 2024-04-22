require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Zip < AbstractPhp80Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4555fccf08876c7e73bc1f7b313dd61373e9f6d30ee805fbef5916ce8925cc9e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e9e7ee21febe0e04013ff9aa1ce203b459166a47a53527f9aa86fec9ac247850"
    sha256 cellar: :any_skip_relocation, monterey:       "6c02b5bf5b3bc7e300ccd376edfb389240f31fef7638187a2005faffdabdaaa8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f45d32a50a3b1fd4279aef7230256fc142030c272587df8604898d5000c6c1b8"
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
