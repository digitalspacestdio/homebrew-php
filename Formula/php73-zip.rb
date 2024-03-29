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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "43a00015615c207571d9946be72ec611bd6c9a2a5474b50f36d6b62800ee528d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bbc5f904cbf587e26deb96d04d27b3d67b2631cf16c0ab968212c61968283683"
    sha256 cellar: :any_skip_relocation, sonoma:        "135b734dfd1ec64458673a882aecabcbb13371275c63ed83c0f4c571e1f6fea4"
    sha256 cellar: :any_skip_relocation, ventura:       "96b085898b33a9207065316cc524124e6bf570c0d77ee956a5f92410abd0c176"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d1d598d1b9e067afe314bf2b547ab4cf2f61f3de0d690e1942efa66dd895d41e"
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
