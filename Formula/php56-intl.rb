    require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Intl < AbstractPhp56Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/5.6.40-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "43e0d96f86ef9295ed48a353a05b34e1baeaeb970d6ad475a77d6d3a3d980b2a"
    sha256 cellar: :any_skip_relocation, monterey:       "b58aac306ab573218e6f398790548f5aa9d3d1c78b07369b11114596001de59e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "65767d5faa833c39350046f2a48ce3c112911e8b68a74bcdb7296f0e0faa61d0"
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
