require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Zip < AbstractPhp74Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "028422f706d5d64bd79d535c1cc6d5122d39c56c1a0f86fd59fdb784ef0bf1bb"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d29c54213e3d05c7c32c5b99153e92b082585ca4a7d68b2b6ba698937e6e3d3e"
    sha256 cellar: :any_skip_relocation, sonoma:        "d424216c51afdc6ae8d33f60a433ee6440aa74afb613e56928acc5393d35a44b"
    sha256 cellar: :any_skip_relocation, monterey:      "9214b29f28bb3101e3eb4eff5503caf3221e986c434005d8a46c16715426e08e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4f0cb25cf1a94a57b85b3a681b31b9a3bf7e8450692bd173cc3cf6354ecbb97b"
  end

  depends_on "libzip"
  depends_on "zlib"
  depends_on "pkg-config" => :build
  depends_on "pcre2"

  def install
    # Required due to icu4c dependency
    ENV.cxx11

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"
    
    Dir.chdir "ext/zip"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-zip",
                          "--with-libzip=#{Formula["libzip"].opt_prefix}",
                          "--with-zlib-dir=#{Formula["zlib"].opt_prefix}",
                          "--with-external-pcre=#{Formula["pcre2"].opt_prefix}"
    system "make"
    prefix.install "modules/zip.so"
    write_config_file if build.with? "config-file"
  end
end
