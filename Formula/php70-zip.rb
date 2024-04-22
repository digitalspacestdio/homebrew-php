require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Zip < AbstractPhp70Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e2f7ecda2b462e16b2cae528c945245c866cddbad2e03ea2f4a78277f612bc52"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "79907620d767bd4072958719113877bb814898d979fd3e76fee342c472a59d1b"
    sha256 cellar: :any_skip_relocation, monterey:       "5d303d55864fd3b3ceb64adbe4aab71e4302a525cffbf32710b40ee7a297fa87"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "33a5adefbd8b1834cdccd8490b3a01fd026277679651520e79ff04ea3ecd875d"
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
