require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Intl < AbstractPhp71Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3e250a6b6faa3c5db0b5cf34c6b2f2edf57b3527e38a2f7fd8588b9d014c4922"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9c81bf9b7b6e5fa3d5b88ae86e8cf8a22efa7b277e2a2f8dcb03215a33d402b2"
    sha256 cellar: :any_skip_relocation, monterey:       "8f9bcd5ac903b06c5a577cf31fb86cfef911a5bd711414fdbd14d580fe0f2bdd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a5c725df690cdfcbfddce96b27e2ab5f32c7c633f30f0b0c75997a4c8bda0e78"
  end

  depends_on "digitalspacestdio/common/icu4c@69.1"

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
