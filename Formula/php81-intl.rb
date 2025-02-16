require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Intl < AbstractPhp81Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cdaec302c6991249d9e7f7ab47fb7c05558804d61f3075ebe99d5ca974a0c897"
    sha256 cellar: :any_skip_relocation, ventura:       "0fc1763d6bc9833ebf6b1ff925371c537037cbcbefebd0b7e9d5208a607f4868"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8f6caf9a3d7f6a390ed8e6256423af6d94ddfad6bd09ff541b39a9228159abf8"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "ddd1e35d6972547a73c9fa92884ffa2670a165e8849722557809eca25c4a3fd7"
  end

  depends_on "digitalspacestdio/common/icu4c@74.2"
  depends_on "pkg-config" => :build

  def install
    # Required due to icu4c dependency
    ENV.cxx11

    # icu4c 61.1 compatability
    #ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    
    Dir.chdir "ext/intl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-intl",
                          "--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@74.2"].opt_prefix}"
    system "make"
    prefix.install "modules/intl.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS

      ;intl.default_locale =
      ; This directive allows you to produce PHP errors when some error
      ; happens within intl functions. The value is the level of the error produced.
      ; Default is 0, which does not produce any errors.
      ;intl.error_level = E_WARNING
    EOS
  end
end
