require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Zip < AbstractPhp71Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "efae405831d669493fb2a61cb60706661afbc40937986ee24e3e00ca22459d7d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0ac09e63e71dff2fef58bcc0b64261f166b0e2287850ab2314d24b826cad76bb"
    sha256 cellar: :any_skip_relocation, monterey:       "c7de03408f8e2daceb163e0eba2dae5a40bb813bffa506391c46db0a3915781f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3be4ff6a5e8ef5adbd54d1467846a1dd21b5ec8f44249ec8fef85fb3ed660003"
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
