require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Intl < AbstractPhp74Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision 27


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e802380bd2320e1d67af95dddd4570f237a987f3cff71fce3bf668bdfd793c3c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6aba42dc4df8c05076968b33e5a3d640f18d8d7d8768e3631a568a71fdd6414b"
    sha256 cellar: :any_skip_relocation, sonoma:        "8bc2944db5485373fb350c7042d9f8f133df3a1aadf90ba746c51c66d0155924"
    sha256 cellar: :any_skip_relocation, ventura:       "c07f54365a059b7616b6442c0e234ded3ca197ed410f7bea4299f25c3d9d1989"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4324e8377e1ea790a41e9eed6dda1b189347899fd7392f8e130f1f7eadbe24e6"
  end

  depends_on "digitalspacestdio/common/icu4c@72.1"
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
