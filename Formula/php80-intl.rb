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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c3473dddc45e29c6bd43960618e9d4b0674d94e223cf184e5b7f03e6d33220ab"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cd84872c97f3a59c88c1efcf9ce549c600513194af7c914a5b50dab5494917b1"
    sha256 cellar: :any_skip_relocation, monterey:       "006a6aa736d3e1551a8eac3ea13569da883d2c515909474dfff953a2ef69ff09"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8571e623e8408cf4f6b066c341cadd03757d6b89b218c5203264992fe2a6c3b9"
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
