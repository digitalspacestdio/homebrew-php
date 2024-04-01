require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Intl < AbstractPhp73Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, sonoma:       "5175d508662bdaf2f2ba7bea541addb3fbbc3b45506ace9339cff0d3c8687aad"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a1d83968f9d69a829bdc64ca96e47e6cc70dc3f2cb4e7b54a7a579fc743ec379"
  end

  depends_on "digitalspacestdio/common/icu4c@69.1"
  depends_on "pkg-config" => :build

  def install
    # icu4c 61.1 compatability
    ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    
    Dir.chdir "ext/intl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-intl",
                          "--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}"
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
