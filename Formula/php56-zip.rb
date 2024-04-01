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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "626770b970a028574f0e41ec637f0b6f0caf350ffe0aa3449390a747ba8f6278"
    sha256 cellar: :any_skip_relocation, sonoma:        "f14931905f8c509d08cb13e69db5216a0fd9669923af4ed0b4ddea8317578cc9"
    sha256 cellar: :any_skip_relocation, monterey:      "293dfbb5e8227daa100946e0061f3700e9a775280430d58532a10d513397d145"
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
