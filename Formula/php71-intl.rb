require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Intl < AbstractPhp71Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision 31

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a416f1ca4263ba32ef511eff8a3768e8ff87228a2d6c84b8ca5abbdd18bc4613"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a9acfde2b0b7321dc0bfb1bc6944a18454d7dfe6ae2aa66e060123e9efd1714a"
    sha256 cellar: :any_skip_relocation, sonoma:        "63189c9160fb95bdea0900bc69e7a175d4906a06e93a6401144dde525e2bce7c"
    sha256 cellar: :any_skip_relocation, ventura:       "a2a48adc72bdd986d43167517595489a1048f4748bc21b8d75bd0235e8daa431"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "66ac00789510f02b8f50679011dc253af6401d575575f733703a7258a3c2520f"
  end

  depends_on "digitalspacestdio/common/icu4c@67.1"

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
                          "--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@67.1"].opt_prefix}"
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
