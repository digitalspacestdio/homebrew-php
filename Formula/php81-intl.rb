require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Intl < AbstractPhp81Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision 2


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f534410417a3de54dae9ae5293a2ffa81c02d478b8a279a62e4e49b141d1eb5e"
    sha256 cellar: :any_skip_relocation, sonoma:        "0058e8b868e1f7bba28c156f334580d0d5d5d02e4c7d1aa0ccd37cb99cbe3a94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0e7f91373f848a25cdb2e1774fbd5db36cc0fb2fef5504a71f389f11783e52ee"
  end

  depends_on "digitalspacestdio/common/icu4c@72.1"
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
                          "--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@72.1"].opt_prefix}"
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
