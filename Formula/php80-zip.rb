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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d7e33030b4d55d225bd98c9a5d0ef7c6e4582355da0a4a50dc93b824fbd04018"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b34050893959eab640a4a12b67807665229efd6462f6171d87ba956d98d73437"
    sha256 cellar: :any_skip_relocation, sonoma:        "0c4e9b55b73b6b8db5e843c9f4c28c900c6762517dc11a7c8deb923a8d3f900e"
    sha256 cellar: :any_skip_relocation, monterey:      "8f03b389440d40187d5e03c668aaf19d21307030bc4646c715d6bbac5e8cfc3d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fca1eb6d6479f107d3790df398e2580896fb607e3b70b09e582d900a48c13b36"
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
