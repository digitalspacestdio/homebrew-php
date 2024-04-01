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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "02eb881b19474949204ebdda718645a8c50fe592d9a7769ba5f46073fc4f5d0d"
    sha256 cellar: :any_skip_relocation, sonoma:        "febc3e373c05769250dda68183ffb3d6226e5891c3cd303b7bb8447df76a511c"
    sha256 cellar: :any_skip_relocation, monterey:      "e52cce5068cd72c8291e31d62d80c2a417fe18119dd96d21ec8c6ae5c6d17479"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2ce9725682d9b5085aab9cee15aec14cad9c030d59b0f2583b3a1fa0e4f40448"
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
