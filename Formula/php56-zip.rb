require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Zip < AbstractPhp56Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d78b3d815bc845d8937330ca639a3bb6fe9d6d8a26bb473f3659474e475c6402"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d3a7b87f8743eaac116bf04c63569c2149c91fd7a161cfe0a4497a9f0e8c49ad"
    sha256 cellar: :any_skip_relocation, sonoma:        "bf033a167e7a7c6a10cb539bfca66aa22cd174cf6cfdb2dfca46c69f4f5107f6"
    sha256 cellar: :any_skip_relocation, monterey:      "627b0c6fea080a9ec2cf4f9a44b836453125445753c78fb57138118c8515557e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7bcee4614a1752acddd9902da45a1158298567b592cf22c06d9e3dd503fcfdaf"
  end

  depends_on "zlib"
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
                          "--with-libzip=#{Formula["libzip"].opt_prefix}",
                          "--with-zlib-dir=#{Formula["zlib"].opt_prefix}"
    system "make"
    prefix.install "modules/zip.so"
    write_config_file if build.with? "config-file"
  end
end
