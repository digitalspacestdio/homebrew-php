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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e672ca8814891a806a706d1e47dae797462dd0941c3d96159d18fd0bb7e74b7f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "101cbf222d42ebf6b277ec84e0d1f8c350aa278a6d212f63c5dc4f67dcc06616"
    sha256 cellar: :any_skip_relocation, sonoma:        "9c56c58d37629eb138d7ee10a396620da058a939021f94e4e8629918f6c51cd4"
    sha256 cellar: :any_skip_relocation, monterey:      "0177b62ad16f0dd1d8ff165c7b9bfed38c3a32d48fb00b1280f3cfc2f812e2bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "40ef3b6961e227d90070014544f46f21bde950c40872695c3ea7862c775e992a"
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
