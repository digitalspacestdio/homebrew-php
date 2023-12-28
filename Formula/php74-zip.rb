require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Zip < AbstractPhp74Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b3cf1a6d6c61c10eec0b734cf326b87f3b2c304ac839a5f3cc2a9734b5950136"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0a469fa8e2a423b1b5a126bb9315483e979f0cbc4c5e66fedd007d3470c1f73e"
    sha256 cellar: :any_skip_relocation, sonoma:        "08af733dbc2e1de267a7e2f252d2a6650e5d117226bb944108df3fa48071f6ea"
    sha256 cellar: :any_skip_relocation, ventura:       "ed2866f062820b5df4e7952508c753c8d3553120e185c3a09c91f4a021ea00db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7797d82dc83232d8e106f38a143b40b78a94a3bb8d1739cb3dc440f3afa9444b"
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
