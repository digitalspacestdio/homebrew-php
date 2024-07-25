require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Zip < AbstractPhp73Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f9aebd13055a745a8da4f4757c0d40e279cd863ef0bb8a4a9dfef304f7c4b243"
    sha256 cellar: :any_skip_relocation, monterey:       "63f0a78f79926db26d1ebdedc2fdccb3d2b681bd20a7d8916a52b7f722cafdc4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a82556e9a8fcc39f41e5317ac4c4d8d4b1a4d92b323d5187848002e4e29fbd70"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "fe21081cfff3a40334c20c697cd9eb353ab9d0f62fb56164246586f24f420330"
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
