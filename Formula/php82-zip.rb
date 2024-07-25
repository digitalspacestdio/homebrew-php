require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Zip < AbstractPhp82Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e07fcbdd5ab67193f0fd3aa6d9af030ab47ca64dd4e13c36fd97e7c4a4feadee"
    sha256 cellar: :any_skip_relocation, monterey:       "479643ea859c355ace41ad8c5c8d384150803ff5356067ff5c1746e8db23ba42"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "467c282475c82be426f4b3c5e5d5a546f1e814c22f6596824e819a0ecbbb6375"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "0f70d8a99a1904ab7b2168dcc9e1d97b496061e6bbf81b218a193b7fd2adca86"
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
