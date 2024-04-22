require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Zip < AbstractPhp74Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "48642f299b837787104c778ff2d8bc073db8a2e2353bc7963ef4b69d328e6ec6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0973a9c28555ed9dba5b64aa60c272afec3cbd63e9612f69088752f7776baddd"
    sha256 cellar: :any_skip_relocation, monterey:       "61354836e146f0b5743819dff74f4bcb041eac9af46ee5a7539f808dbbef2778"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3d42dd3a52fc564dfa4a3a5d8806a2b205ce9be2a5dc4a6ffb726a9032609189"
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
