require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Intl < AbstractPhp70Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cebcbd38e799c0fd29833c82f3a79c9616116a33809dd9bb598b45af81144aab"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "df29b5e77122e21618e158037e9f3e2de4a6342c041ba23fc9fa7b0c5dce31c3"
    sha256 cellar: :any_skip_relocation, sonoma:        "b5ace626606abedc7fe71aa01ebd6c7f70f31f11c029372869a036faa0c2ff27"
    sha256 cellar: :any_skip_relocation, monterey:      "217c2ad8a64791517b1346f0674ee216dc17e1cbbb391a2181f08e425c59c21e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7c2270e4ad96ca3ad32fbdd874560a3208ce50674317fa244536d94d2c5dcc46"
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
