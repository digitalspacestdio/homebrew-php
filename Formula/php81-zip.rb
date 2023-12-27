require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Zip < AbstractPhp81Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e1ddeffcebc49c5845738bf340f6472d37f32bcf552de816f462c2beb7723191"
    sha256 cellar: :any_skip_relocation, sonoma:        "641dcea5f07507c78c52c7ae7b45ce9e49609d59546059e9504426407c4c4759"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "955dd81a51155804224c3346dfda181e1259f0e0e294dc8a2e66eee3225b9beb"
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
