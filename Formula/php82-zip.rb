require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Zip < AbstractPhp82Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.2.20-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "449b73120f2da826abdd74a671805ae07bb85b2efaf470e5259bd348e73defe1"
    sha256 cellar: :any_skip_relocation, monterey:       "e0fd8f31bc480e4be2d16235ea739778c68f3678009f4e7b769eeb7c81aa8c82"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2be6d1146c556c7085bce4cb6b086ec3d44f369955c8d94da495098e4716f7b6"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "f489b6feb050369d27e777079c3e04379c6c1151c8d99b61f0f2cf3a585ad5cd"
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
