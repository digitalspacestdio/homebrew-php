require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Intl < AbstractPhp80Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b676c97414b9ec50ddab0611e0bc746e4bbf6eee8a0cd93b18d44239f0721c91"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9435f55689b35bb57226883f27d7d4c7a440c6c1c7b5154d989125fe186d6ccd"
    sha256 cellar: :any_skip_relocation, sonoma:        "04e3585acdae2f03766d133d5e17055794abfbe4db3cd51ccce2a2dab722451e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5d6da1ae8de020412d2c3cebd254602727db134e82db77a98c4b27b9a8666e65"
  end

  depends_on "digitalspacestdio/common/icu4c@74.2"
  depends_on "pkg-config" => :build

  def install
        # Required due to icu4c dependency
    ENV.cxx11

    # icu4c 61.1 compatability
    ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    
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
