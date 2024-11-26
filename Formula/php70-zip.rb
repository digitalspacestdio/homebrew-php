require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Zip < AbstractPhp70Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5313a98e72ae230a9743a9b2e076a0a069ec69acf6d03511bfb9bd4d863c8d88"
    sha256 cellar: :any_skip_relocation, monterey:       "5e5c0eecbe96101f25f196e7da106329ebe7291b3044b6e180639b8736c9c11b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a0a9b1c77e0efa20c72b1707c3d499ce93cb94dc056360f9cfc65f15ac209577"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "61049ac63866e45565ed0c5665f5f71efb46adfd1616f225d77e2778f5f2253c"
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
