require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Zip < AbstractPhp83Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c7d39d1205b7c0f1bd4eae0233ebabc58d20bf8d4f5a3f6a8c6715c1dd6a2e6e"
    sha256 cellar: :any_skip_relocation, sonoma:        "61d052f59a58866a9f64a9edc978ce3af8bcc2ee1244916d4a3f24d654cf84ea"
  end

  depends_on "libzip"
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
                          "--with-libzip=#{Formula["libzip"].opt_prefix}"
    system "make"
    prefix.install "modules/zip.so"
    write_config_file if build.with? "config-file"
  end
end
