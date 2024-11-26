require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Zip < AbstractPhp82Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.26-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "229b1f5d0c32fc6fcc67dab537ba8dfe2d43128b531c645ce93d953d4a2f032d"
    sha256 cellar: :any_skip_relocation, ventura:       "104f9cbfa546b5d311113159d8e5dd6ed9d9469ed13a3653718e6d53d91e6c37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "57554dd77b9c3fdf55c0d8b785b6eb1ba7ae7cff92ad6ea596806a56eef1170b"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "063b470dc428907fa3fb794af11c30c9be4c10a0fb8a182d3635e93c6dfccdde"
  end

  depends_on "libzip"
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
                          "--with-external-pcre=#{Formula["pcre2"].opt_prefix}"
    system "make"
    prefix.install "modules/zip.so"
    write_config_file if build.with? "config-file"
  end
end
