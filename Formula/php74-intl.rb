require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Intl < AbstractPhp74Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "75d76dac206ccbd96f51dcfbe315779a0d989bec14254b8843e67c5f775168de"
    sha256 cellar: :any_skip_relocation, monterey:      "1d6491b5e3cdc88836ebf0fbe21d9f3697a16c4feecb274c7d8d3cb4bd9b1338"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ed053c600800e61bc321eaaa0b0900721ee87acf5f04375712e65ebd5215ed0b"
  end

  depends_on "digitalspacestdio/common/icu4c@73.2"
  depends_on "pkg-config" => :build

  def install
    # icu4c 61.1 compatability
    ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/icu4c@73.2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/icu4c@73.2"].opt_prefix}/include"
    
    Dir.chdir "ext/intl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-intl"
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
