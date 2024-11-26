require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Zip < AbstractPhp71Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "57582c77839bf05ad858679c760bc5e09fd6463ea5e7d80f13ecaa344a16b365"
    sha256 cellar: :any_skip_relocation, monterey:       "ce6b98832c3c0c9c1006de961dd0dd0f4c89c6b848a9f2cbd67bfc96cfedb9bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e8bb092bbcfb288cae03cf64b7df9c81c479203570fe74bb6d9bc12e72b71ee7"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "c3d401bb55a129c83a650b007b889fee729417b9b0f75d87959c7122b765221d"
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
