require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Intl < AbstractPhp70Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision 29


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1df01c225010dcf328ca3b8bfe7cbed68a4b33cc3efe899f1b432bbdb2e771b0"
    sha256 cellar: :any_skip_relocation, sonoma:        "65c0b8186f79ec4303d7a433649f116351ce911b87cdfc3eec1c11a53165f483"
    sha256 cellar: :any_skip_relocation, ventura:       "28940735c9a2faa701ddd58e1a98d7d8d1f2ea7aaa9ac48be72aeabb73577ec6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c6d1b814b378aa13e2e450e2e8b05b0926c355ccef52d5df2c47d87d7774044"
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
