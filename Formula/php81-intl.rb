require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Intl < AbstractPhp81Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "38f4afb6fc44b3ccda9acb4b241056fada2c7c9048299b31a40f0656a0de53ff"
    sha256 cellar: :any_skip_relocation, monterey:       "b08584c1f89576a2d26fa56f91e5719a969a7787b295a70b0193e14d6e338578"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4c871dcef98decc8c7dd30bd3ea48cf7ef5416dc5d48a024c177c4b2cf0cb4e2"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "0e4bfb3d11bc5f09cc38728d09bcfd783e8335e12f112018fc8335eefec1bfb2"
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
