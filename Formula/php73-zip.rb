require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Zip < AbstractPhp73Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "553ebf1b1c53d95c4e4126f4202d1f449f31fd70d25b9a9804e9bd8e77b91592"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "93bfb063e42dbfdc3cea84d6f0e10c0a03a6cd1b55bdf54d943ee4160a9d3b9e"
    sha256 cellar: :any_skip_relocation, sonoma:        "a8754ff89886c303acf0e955d01b66604e6129925a07561f1e4992b63c3496ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ca250f1cc4b7b025d7d6bcdf02e02535e6f42282ab5c228860546df696424cf5"
  end

  depends_on "libzip"
  depends_on "zlib"
  depends_on "pkg-config" => :build

  def install
        # Required due to icu4c dependency
    ENV.cxx11

    # icu4c 61.1 compatability
    #ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    
    Dir.chdir "ext/zip"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-zip",
                          "--with-libzip=#{Formula["libzip"].opt_prefix}",
                          "--with-zlib-dir=#{Formula["zlib"].opt_prefix}"
    system "make"
    prefix.install "modules/zip.so"
    write_config_file if build.with? "config-file"
  end
end
