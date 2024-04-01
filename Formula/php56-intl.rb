    require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Intl < AbstractPhp56Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d5e608937847a1e78c98502f1464a4e18612324cb847a5dcf60b6fd6db290333"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cffe5476fa8f3a477b372169481320306774a2aa0df0a162940be946598ec9e0"
    sha256 cellar: :any_skip_relocation, sonoma:        "c9f0372a615adb0bac5b9d05d9607d41f06f2424940156781cc81841f8a87f6e"
    sha256 cellar: :any_skip_relocation, monterey:      "309987a0b631d5b46a1c0c4df4d5c01e7936b6b154b9f899529dad6b837b4bb2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f1f7215897680944ef11873bd70b36def7cfa2b7607a65eb099a128289e5107f"
  end

  depends_on "digitalspacestdio/common/icu4c@69.1"

  patch do
    url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php56/php-5.6-intl-detect-icu-via-pkg-config.patch"
    sha256 "ea5fa9d12a2a464e9cc5ba1be7b1ce453842aca5de9c7522ba82b14df85abbc7"
  end

  def install
    # Required due to icu4c dependency
    ENV.cxx11

    # icu4c 61.1 compatability
    ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"

    # Work around configure issues with Xcode 12
    # See https://bugs.php.net/bug.php?id=80171
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    # Workaround for https://bugs.php.net/80310
    ENV.append "CFLAGS", "-DU_DEFINE_FALSE_AND_TRUE=1"
    ENV.append "CXXFLAGS", "-DU_DEFINE_FALSE_AND_TRUE=1"

    ENV.append "CFLAGS", "-fcommon"    

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
